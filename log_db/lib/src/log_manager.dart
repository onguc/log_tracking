/// Created by onguc
/// on 25.12.2024

import 'dart:convert';
import 'dart:io';
import 'package:log_db/src/date_index.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

var lockLog = Lock();
var lockIndex = Lock();

class LogIndex {
  final String field;
  final Map<String, List<int>> index = {};
  final String indexPath;

  LogIndex(this.field, String baseDir) : indexPath = path.join(baseDir, '${field}_index.json');

  Future<void> load() async {
    try {
      final file = File(indexPath);
      if (await file.exists()) {
        var content = await file.readAsString();
        if (content.isEmpty) content = "{}";

        try {
          Map<String, dynamic> data = json.decode(content);
          data!.forEach((key, value) {
            index[key] = List<int>.from(value);
          });
        } catch (e) {
          int x = 0;
          print(e);
        }
      } else {
        await file.create();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> save() {
    return lockIndex.synchronized(() async {
      final file = File(indexPath);
      try {
        await file.writeAsString(json.encode(index));
      } catch (e) {
        int x = 0;
      }
    });
  }

  void addEntry(String key, int position) {
    index.putIfAbsent(key, () => []).add(position);
  }

  Set<int> getPositions(String key) {
    return index[key]?.toSet() ?? {};
  }
}

class LogManager {
  late String logFilePath;
  late String basePath;
  String indexDir = "indices";
  late final File _logFile;
  late final LogIndex statusIndex;
  late final LogIndex logTypeIndex;
  late final DateIndex dateIndex;
  late final LogIndex errorIndex;
  int _currentPosition = 0;

  LogManager._();

  static LogManager? _instanse;

  static Future<LogManager> open(bool saveToLocal) async {
    if (_instanse == null) {
      LogManager logDatabase = LogManager._();
      if (saveToLocal) {
        lockLog.synchronized(() async {
          await logDatabase.initialize();
        });
      }
      _instanse = logDatabase;
    }
    return _instanse!;
  }

  Future<void> _createFolderIfNotExists() async {
    final directory = await getApplicationDocumentsDirectory();
    var dir = Directory(path.join(directory.path, "logs"));
    var mainPath = dir.path;
    if (!(await dir.exists())) {
      var directory = await dir.create();
      mainPath = directory.path;
    }
    basePath = mainPath;
  }

  Future<void> initialize() async {
    await _createFolderIfNotExists();
    // await Directory(indexDir).create(recursive: true);
    logFilePath = path.join(basePath, "logs.jsonl");
    _logFile = File(logFilePath);
    if (!await _logFile.exists()) {
      await _logFile.create();
    }

    statusIndex = LogIndex('status', basePath);
    logTypeIndex = LogIndex('logType', basePath);
    dateIndex = DateIndex('dateTime', basePath);
    errorIndex = LogIndex('errorIndex', basePath);
    await _loadIndices();
    await _rebuildIndicesIfNeeded();
  }

  Future<void> _loadIndices() async {
    await Future.wait([
      statusIndex.load(),
      logTypeIndex.load(),
      dateIndex.load(),
      errorIndex.load(),
    ]);
  }

  Future<void> _rebuildIndicesIfNeeded() async {
    if (_currentPosition == 0) {
      await _buildIndices();
    }
  }

  Future<void> _buildIndices() async {
    _currentPosition = 0;
    final lines = _logFile.openRead().transform(utf8.decoder).transform(const LineSplitter());

    await for (var line in lines) {
      if (line.isEmpty) {
        _currentPosition += line.length + 1;
        continue;
      }

      try {
        final jsonData = json.decode(line);
        _indexLog(jsonData, _currentPosition);
      } catch (e) {
        int x = 0;
      }
      _currentPosition += line.length + 1;
    }

    await Future.wait([
      statusIndex.save(),
      logTypeIndex.save(),
      dateIndex.save(),
      errorIndex.save(),
    ]);
  }

  void _indexLog(Map<String, dynamic> jsonData, int position) {
    // Status indeksi
    if (jsonData['status'] != null) {
      statusIndex.addEntry(jsonData['status'], position);
    }

    // LogType indeksi
    if (jsonData['logType'] != null) {
      logTypeIndex.addEntry(jsonData['logType'], position);
    }

    // DateTime indeksi (günlük bazda)
    if (jsonData['dateTime'] != null) {
      final date = jsonData['dateTime'];
      dateIndex.addEntry(date, position);
    }

    // ErrorIndex indeksi
    if (jsonData['errorIndex'] != null) {
      errorIndex.addEntry(jsonData['errorIndex'].toString(), position);
    }
  }

  Future<void> insertLog(Map<String, dynamic> map) {
    return lockLog.synchronized(() async {
      final jsonString = json.encode(map);
      final position = _currentPosition;
      await _logFile.writeAsString('$jsonString\n', mode: FileMode.append);

      // final Map<String, dynamic> jsonData = json.decode(jsonString);
      _indexLog(map, position);
      _currentPosition += jsonString.length + 1;

      // İndeksleri kaydet
      await Future.wait([
        statusIndex.save(),
        logTypeIndex.save(),
        dateIndex.save(),
        errorIndex.save(),
      ]);
    });
  }

  Future<void> deleteByPositions() async {
    final unsentPositions = statusIndex.getPositions("unsent");
    if (unsentPositions.isEmpty) return;

    // Temp dosya adını düzgün oluştur
    final tempFilePath = '${logFilePath}.temp';
    final tempFile = File(tempFilePath);
    final file = await _logFile.open(mode: FileMode.read);
    final tempWrite = await tempFile.open(mode: FileMode.write);

    bool success = false;
    try {
      var currentPos = 0;

      while (true) {
        await file.setPosition(currentPos);
        final line = await _readLine(file);
        if (line.isEmpty) break;

        if (unsentPositions.contains(currentPos)) {
          final jsonData = json.decode(line);
          jsonData['status'] = "sent";
          await tempWrite.writeString('${json.encode(jsonData)}\n');

          // İndeksi güncelle
          statusIndex.getPositions("unsent").remove(currentPos);
          statusIndex.addEntry("sent", currentPos);
        } else {
          await tempWrite.writeString('$line\n');
        }

        currentPos += line.length + 1;
      }

      success = true;
    } finally {
      await file.close();
      await tempWrite.close();
    }

    if (success) {
      try {
        // Önce eski dosyayı yedekle
        final backupPath = '${logFilePath}.bak';
        await _logFile.copy(backupPath);

        // Temp dosyayı asıl dosya yap
        await tempFile.rename(logFilePath);

        // Yedek dosyayı sil
        final backupFile = File(backupPath);
        if (await backupFile.exists()) {
          await backupFile.delete();
        }

        // İndeksleri kaydet
        await statusIndex.save();
      } catch (e) {
        // Hata durumunda eski dosyayı geri getir
        final backupFile = File('${logFilePath}.bak');
        if (await backupFile.exists()) {
          await backupFile.rename(logFilePath);
        }
        rethrow;
      }
    } else {
      int x = 0;
      // İşlem başarısız olduysa temp dosyayı sil
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      throw Exception('Log güncelleme işlemi başarısız oldu');
    }
  }

  // Future<void> updateList(List<Map<String,dynamic>> list){
  //   for(var map in list){
  //     var dateTime = map['dateTime']!;
  //     var position = dateIndex.getPosition(dateTime);
  //
  //   }
  // }

  Future<void> updateUnsentToSent() async {
    final unsentPositions = statusIndex.getPositions("unsent");
    if (unsentPositions.isEmpty) return;

    // Temp dosya adını düzgün oluştur
    final tempFilePath = '${logFilePath}.temp';
    final tempFile = File(tempFilePath);
    final file = await _logFile.open(mode: FileMode.read);
    final tempWrite = await tempFile.open(mode: FileMode.write);

    bool success = false;
    try {
      var currentPos = 0;

      while (true) {
        await file.setPosition(currentPos);
        final line = await _readLine(file);
        if (line.isEmpty) break;

        if (unsentPositions.contains(currentPos)) {
          final jsonData = json.decode(line);
          jsonData['status'] = "sent";
          await tempWrite.writeString('${json.encode(jsonData)}\n');

          // İndeksi güncelle
          statusIndex.getPositions("unsent").remove(currentPos);
          statusIndex.addEntry("sent", currentPos);
        } else {
          await tempWrite.writeString('$line\n');
        }

        currentPos += line.length + 1;
      }

      success = true;
    } finally {
      await file.close();
      await tempWrite.close();
    }

    if (success) {
      try {
        // Önce eski dosyayı yedekle
        final backupPath = '${logFilePath}.bak';
        await _logFile.copy(backupPath);

        // Temp dosyayı asıl dosya yap
        await tempFile.rename(logFilePath);

        // Yedek dosyayı sil
        final backupFile = File(backupPath);
        if (await backupFile.exists()) {
          await backupFile.delete();
        }

        // İndeksleri kaydet
        await statusIndex.save();
      } catch (e) {
        // Hata durumunda eski dosyayı geri getir
        final backupFile = File('${logFilePath}.bak');
        if (await backupFile.exists()) {
          await backupFile.rename(logFilePath);
        }
        rethrow;
      }
    } else {
      int x = 0;
      // İşlem başarısız olduysa temp dosyayı sil
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
      throw Exception('Log güncelleme işlemi başarısız oldu');
    }
  }

  Future<int> deleteLogsSent7DaysEgo() async {
    var tempSink;
    int count = 0;
    try {
      String status = "sent";
      var startDate = DateTime.now().subtract(Duration(days: 7));

      final tempFilePath = '${logFilePath}.temp';
      final tempFile = File(tempFilePath);
      tempSink = tempFile.openWrite();
      final lines = await _logFile.readAsLines();
      for (var line in lines) {
        final log = jsonDecode(line);
        if (log.dateTime!.isAfter(startDate) || log[status] != 'sent') {
          tempSink.writeln(jsonEncode(log));
          // indeksler eklenmeli
        } else {
          count++;
        }
      }
      await tempSink.close();

      try {
        // Önce eski dosyayı yedekle
        final backupPath = '${logFilePath}.bak';
        await _logFile.copy(backupPath);

        // Temp dosyayı asıl dosya yap
        await tempFile.rename(logFilePath);

        // Yedek dosyayı sil
        final backupFile = File(backupPath);
        if (await backupFile.exists()) {
          await backupFile.delete();
        }

        // İndeksleri kaydet
        await statusIndex.save();
      } catch (e) {
        // Hata durumunda eski dosyayı geri getir
        final backupFile = File('${logFilePath}.bak');
        if (await backupFile.exists()) {
          await backupFile.rename(logFilePath);
        }
        rethrow;
      }
    } catch (e) {
      int x = 0;
      // İşlem başarısız olduysa temp dosyayı sil
      if (await tempSink.exists()) {
        await tempSink.delete();
      }
      throw Exception('Log güncelleme işlemi başarısız oldu');
    }
    return count;
  }

  Future<List<Map<String, dynamic>>> getLogsByStatus(String status) async {
    final positions = statusIndex.getPositions(status);
    return _readLogsAtPositions(positions);
  }

  Future<List<Map<String, dynamic>>> getLogsByDateRange(DateTime startDate, DateTime endDate) async {
    final Set<int> positions = {};
    while (!startDate.isAfter(endDate)) {
      positions.add(dateIndex.getPosition(startDate.toIso8601String()));
      startDate = startDate.add(const Duration(days: 1));
    }

    return _readLogsAtPositions(positions);
  }

  Future<List<Map<String, dynamic>>> queryByLogType(String logType) async {
    final positions = logTypeIndex.getPositions(logType);
    return _readLogsAtPositions(positions);
  }

  Future<List<Map<String, dynamic>>> queryByErrorIndex(int errorIndex) async {
    final positions = this.errorIndex.getPositions(errorIndex.toString());
    return _readLogsAtPositions(positions);
  }

  Future<List<Map<String, dynamic>>> getUnsentLogByErrorIndex(int errorIndex) async {
    final positions = this.errorIndex.getPositions(errorIndex.toString());
    var positions2 = this.statusIndex.getPositions("unsent");
    Set<int> pos = {};
    for (var value in positions) {
      if (positions2.contains(value)) {
        pos.add(value);
      }
    }
    return _readLogsAtPositions(pos);
  }

  Future<List<Map<String, dynamic>>> _readLogsAtPositions(Set<int> positions) async {
    if (positions.isEmpty) return [];

    final logs = <Map<String, dynamic>>[];
    final file = await _logFile.open();

    try {
      for (final position in positions) {
        await file.setPosition(position);
        final line = await _readLine(file);
        try {
          if (line.isNotEmpty) {
            final jsonData = json.decode(line);
            logs.add(jsonData);
          }
        } catch (e) {
          int x = 0;
        }
      }
    } finally {
      await file.close();
    }

    return logs;
  }

  Future<String> _readLine(RandomAccessFile file) async {
    final buffer = StringBuffer();
    var byte = await file.readByte();

    while (byte != 10 && byte != -1) {
      // 10 is newline
      buffer.write(String.fromCharCode(byte));
      byte = await file.readByte();
    }
    return buffer.toString();
  }
}
