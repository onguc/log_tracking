import 'dart:async';

/// Web (JavaScript and WebAssembly) counterpart of the file based store.
///
/// Local storage is not available on web, so [openDefaultStore] always returns
/// null and every [LogStore] method is a no-op. Keeping the same API lets the
/// shared code compile for web without importing `dart:io`.

/// A position in the store: a segment file name and a byte offset inside it.
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

/// Unsent log entries read from the store.
class LogBatch {
  /// Decoded log entries, oldest first
  final List<Map<String, dynamic>> logs;

  /// Position right after the last line read
  final LogCursor? end;

  /// Whether more unsent entries exist after [end]
  final bool hasMore;

  /// Creates a batch
  const LogBatch(this.logs, this.end, this.hasMore);
}

/// No-op log store used on web, where local storage is not available.
class LogStore {
  LogStore._();

  /// Always zero on web
  int get launchIndex => 0;

  /// Always one on web
  int get errorIndex => 1;

  /// Ignored on web
  Future<void> append(Map<String, dynamic> entry) async {}

  /// Always empty on web
  Future<LogBatch> readUnsent({int maxLogs = 500}) async =>
      const LogBatch([], null, false);

  /// Ignored on web
  Future<void> markSent(LogCursor end) async {}

  /// Ignored on web
  Future<void> increaseErrorIndex() async {}
}

/// Local storage is unavailable on web, so this always returns null.
Future<LogStore?> openDefaultStore() async => null;

/// Local storage is unavailable on web, so there is nothing to delete.
Future<void> deleteLegacyLogFiles() async {}
