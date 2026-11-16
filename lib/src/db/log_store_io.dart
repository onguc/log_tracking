import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

/// Opens the store inside the application support directory.
///
/// Returns null when the directory cannot be resolved or opened; local storage
/// is then unavailable but logging keeps working.
Future<LogStore?> openDefaultStore() async {
  try {
    final support = await getApplicationSupportDirectory();
    return await LogStore.open(
        Directory(path.join(support.path, 'log_tracking')));
  } catch (e) {
    if (kDebugMode) debugPrint('log_tracking: $e');
    return null;
  }
}

/// Removes the files of the old index based storage (0.4.x) from the documents directory.
Future<void> deleteLegacyLogFiles() async {
  try {
    final documents = await getApplicationDocumentsDirectory();
    final dir = Directory(path.join(documents.path, 'logs'));
    if (!await dir.exists()) return;
    const names = [
      'logs.jsonl',
      'logs.jsonl.temp',
      'logs.jsonl.bak',
      'status_index.json',
      'logType_index.json',
      'dateTime_index.json',
      'errorIndex_index.json',
    ];
    for (final name in names) {
      final file = File(path.join(dir.path, name));
      if (await file.exists()) await file.delete();
    }
    if (await dir.list().isEmpty) await dir.delete();
  } catch (e) {
    if (kDebugMode) debugPrint('log_tracking: $e');
  }
}

/// A position in the store: a segment file name and a byte offset inside it
class LogCursor implements Comparable<LogCursor> {
  /// Segment file name, e.g. `logs_20261022_000.jsonl`
  final String segment;

  /// Byte offset inside [segment]
  final int offset;

  /// Creates a cursor
  const LogCursor(this.segment, this.offset);

  @override
  int compareTo(LogCursor other) {
    final bySegment = segment.compareTo(other.segment);
    return bySegment != 0 ? bySegment : offset.compareTo(other.offset);
  }
}

/// Unsent log entries read from the store
class LogBatch {
  /// Decoded log entries, oldest first
  final List<Map<String, dynamic>> logs;

  /// Position right after the last line read; pass it to [LogStore.markSent]
  final LogCursor? end;

  /// Whether more unsent entries exist after [end]
  final bool hasMore;

  /// Creates a batch
  const LogBatch(this.logs, this.end, this.hasMore);
}

/// Append-only, file based log store.
///
/// Logs are written as JSON lines into daily segment files and are never rewritten in place.
/// The "sent" state is a single cursor kept in `state.json`, which is replaced atomically.
/// Segments are removed by age and by total size, so the store cannot grow without limit.
class LogStore {
  LogStore._(this.directory, this.maxTotalBytes, this.maxSegmentBytes,
      this.maxAge, this._now);

  /// Directory that holds the segments and the state file
  final Directory directory;

  /// Upper limit for the total size of all segments
  final int maxTotalBytes;

  /// A new segment is started when the current one would exceed this size
  final int maxSegmentBytes;

  /// Segments older than this are deleted
  final Duration maxAge;

  /// Clock, replaceable in tests
  final DateTime Function() _now;

  /// Serializes every file operation of the store
  final Lock _lock = Lock();

  /// Incremented once per [open]
  int _launchIndex = 0;

  /// Logs up to and including an error share the same index
  int _errorIndex = 1;

  /// Everything before this position has been sent; null means nothing was sent
  LogCursor? _sent;

  /// Segment new logs are appended to
  String? _segment;

  /// Size of [_segment] in bytes
  int _segmentSize = 0;

  static const String _stateFileName = 'state.json';
  static const String _segmentPrefix = 'logs_';
  static const String _segmentSuffix = '.jsonl';
  static const int _newline = 10;

  /// Index of the current app launch
  int get launchIndex => _launchIndex;

  /// Index of the current error group
  int get errorIndex => _errorIndex;

  /// Opens (or creates) the store in [directory] and counts a new app launch
  static Future<LogStore> open(
    Directory directory, {
    int maxTotalBytes = 5 * 1024 * 1024,
    int maxSegmentBytes = 512 * 1024,
    Duration maxAge = const Duration(days: 7),
    DateTime Function()? now,
  }) async {
    final store = LogStore._(
        directory, maxTotalBytes, maxSegmentBytes, maxAge, now ?? DateTime.now);
    await store._lock.synchronized(store._open);
    return store;
  }

  Future<void> _open() async {
    await directory.create(recursive: true);
    await _readState();
    _launchIndex++;
    await _repairLastSegment();
    await _applyRetention();
    await _writeState();
  }

  /// Appends one log entry
  Future<void> append(Map<String, dynamic> entry) {
    final bytes = utf8.encode('${jsonEncode(entry)}\n');
    return _lock.synchronized(() async {
      final file = await _targetSegment(bytes.length);
      await file.writeAsBytes(bytes, mode: FileMode.append);
      _segmentSize += bytes.length;
    });
  }

  /// Reads at most [maxLogs] entries that come after the sent cursor
  Future<LogBatch> readUnsent({int maxLogs = 500}) {
    return _lock.synchronized(() async {
      final logs = <Map<String, dynamic>>[];
      final sent = _sent;
      LogCursor? end;
      for (final file in await _segments()) {
        final name = path.basename(file.path);
        if (sent != null && name.compareTo(sent.segment) < 0) continue;
        final bytes = await file.readAsBytes();
        var position = sent != null && name == sent.segment ? sent.offset : 0;
        if (position > bytes.length) position = bytes.length;
        while (position < bytes.length) {
          if (logs.length >= maxLogs) return LogBatch(logs, end, true);
          final newline = bytes.indexOf(_newline, position);
          // An unfinished last line is still being written; it is read next time
          if (newline < 0) break;
          final entry = _decode(bytes, position, newline);
          position = newline + 1;
          end = LogCursor(name, position);
          if (entry != null) logs.add(entry);
        }
      }
      return LogBatch(logs, end, false);
    });
  }

  /// Marks everything before [end] as sent
  Future<void> markSent(LogCursor end) {
    return _lock.synchronized(() async {
      final sent = _sent;
      if (sent != null && end.compareTo(sent) <= 0) return;
      _sent = end;
      await _writeState();
    });
  }

  /// Starts a new error group; called after an error log is saved
  Future<void> increaseErrorIndex() {
    return _lock.synchronized(() async {
      _errorIndex++;
      await _writeState();
    });
  }

  /// Returns the segment the next [length] bytes go to, starting a new one when needed
  Future<File> _targetSegment(int length) async {
    final day = _dayKey(_now());
    final current = _segment;
    if (current != null && _dayOf(current) == day) {
      if (_segmentSize == 0 || _segmentSize + length <= maxSegmentBytes) {
        return _file(current);
      }
      return _startSegment(day, _partOf(current) + 1);
    }

    // First write of this launch or a new day: continue the day's last segment if it has room
    final existing = (await _segments())
        .map((file) => path.basename(file.path))
        .where((name) => _dayOf(name) == day);
    if (existing.isEmpty) return _startSegment(day, 0);
    final last = existing.last;
    final size = await _file(last).length();
    if (size + length > maxSegmentBytes) {
      return _startSegment(day, _partOf(last) + 1);
    }
    _segment = last;
    _segmentSize = size;
    return _file(last);
  }

  Future<File> _startSegment(String day, int part) async {
    final name =
        '$_segmentPrefix${day}_${part.toString().padLeft(3, '0')}$_segmentSuffix';
    _segment = name;
    _segmentSize = 0;
    await _applyRetention();
    return _file(name);
  }

  /// Deletes segments older than [maxAge], then the oldest ones until the total fits [maxTotalBytes]
  Future<void> _applyRetention() async {
    final oldestDay = _dayKey(_now().subtract(maxAge));
    final kept = <(File, int)>[];
    var total = 0;
    for (final file in await _segments()) {
      final name = path.basename(file.path);
      if (name != _segment && _dayOf(name).compareTo(oldestDay) < 0) {
        await _delete(file);
        continue;
      }
      final size = await file.length();
      kept.add((file, size));
      total += size;
    }
    // The newest segment is always kept
    for (var i = 0; i < kept.length - 1 && total > maxTotalBytes; i++) {
      final (file, size) = kept[i];
      if (path.basename(file.path) == _segment) continue;
      await _delete(file);
      total -= size;
    }
  }

  /// Terminates a line left unfinished by a crash, so the next entry starts on its own line
  Future<void> _repairLastSegment() async {
    final segments = await _segments();
    if (segments.isEmpty) return;
    final last = segments.last;
    final length = await last.length();
    if (length == 0) return;
    final tail = await last.openRead(length - 1, length).first;
    if (tail.isNotEmpty && tail.last != _newline) {
      await last
          .writeAsBytes(const [_newline], mode: FileMode.append, flush: true);
    }
  }

  Future<void> _readState() async {
    final file = File(path.join(directory.path, _stateFileName));
    try {
      if (!await file.exists()) return;
      final data = jsonDecode(await file.readAsString());
      if (data is! Map) return;
      final launchIndex = data['launchIndex'];
      final errorIndex = data['errorIndex'];
      final segment = data['sentSegment'];
      final offset = data['sentOffset'];
      if (launchIndex is int) _launchIndex = launchIndex;
      if (errorIndex is int) _errorIndex = errorIndex;
      if (segment is String && offset is int) {
        _sent = LogCursor(segment, offset);
      }
    } catch (_) {
      // A damaged state file only resets the counters; the logs stay readable
    }
  }

  /// Writes the state to a temp file and renames it, so the state file is never half written
  Future<void> _writeState() async {
    final file = File(path.join(directory.path, _stateFileName));
    final temp = File('${file.path}.tmp');
    await temp.writeAsString(
      jsonEncode({
        'launchIndex': _launchIndex,
        'errorIndex': _errorIndex,
        'sentSegment': _sent?.segment,
        'sentOffset': _sent?.offset,
      }),
      flush: true,
    );
    await temp.rename(file.path);
  }

  /// Segment files sorted from oldest to newest
  Future<List<File>> _segments() async {
    final files = <File>[];
    await for (final entity in directory.list(followLinks: false)) {
      final name = path.basename(entity.path);
      if (entity is File &&
          name.startsWith(_segmentPrefix) &&
          name.endsWith(_segmentSuffix)) {
        files.add(entity);
      }
    }
    files
        .sort((a, b) => path.basename(a.path).compareTo(path.basename(b.path)));
    return files;
  }

  File _file(String name) => File(path.join(directory.path, name));

  static Future<void> _delete(File file) async {
    try {
      await file.delete();
    } catch (_) {
      // Retried on the next retention pass
    }
  }

  static Map<String, dynamic>? _decode(List<int> bytes, int start, int end) {
    if (end <= start) return null;
    try {
      final value = jsonDecode(
          const Utf8Decoder(allowMalformed: true).convert(bytes, start, end));
      return value is Map<String, dynamic> ? value : null;
    } catch (_) {
      // A damaged line is skipped
      return null;
    }
  }

  /// Local date as `yyyyMMdd`, used in segment names
  static String _dayKey(DateTime date) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${date.year.toString().padLeft(4, '0')}${two(date.month)}${two(date.day)}';
  }

  static String _dayOf(String segment) {
    final start = _segmentPrefix.length;
    return segment.length >= start + 8
        ? segment.substring(start, start + 8)
        : '';
  }

  static int _partOf(String segment) {
    final start = _segmentPrefix.length + 9;
    if (segment.length < start + 3) return 0;
    return int.tryParse(segment.substring(start, start + 3)) ?? 0;
  }
}
