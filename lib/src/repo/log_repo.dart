// import 'dart:io';
//
// import 'package:device_info/device_info.dart';
// import 'package:log_tracking/log_tracking.dart';
// import 'package:log_tracking/src/external_storage.dart';
// import 'package:log_tracking/src/helper/db_log_helper.dart';
// import 'package:log_tracking/src/helper/log_helper.dart';
// import 'package:log_tracking/src/model/eskiler/log.dart';
// import 'package:log_tracking/src/utils/date_time_util.dart';
// import 'package:log_tracking/src/utils/util.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:sqflite/sqlite_api.dart';
//
// /// Created by İrfan Öngüç
// /// on 14 October 2020

import 'package:log_tracking/src/model/ngc_log.dart';
import 'package:log_tracking/src/model/ngc_log_status.dart';
import 'package:log_tracking/src/repo/ngc_log_repo.dart';
import 'package:log_tracking/src/repo/ngc_log_status_repo.dart';

class LogRepo {
  Future<(List<NgcLogStatus>, List<NgcLog>)> getUnsentLogs() async {
    List<NgcLogStatus> unSentLogStatusList = NgcLogStatusRepo.instance.getLogStatusesUnsent().toList();
    if (unSentLogStatusList.isEmpty) return (<NgcLogStatus>[], <NgcLog>[]);
    Set<String> unsentLogIndexKeySet = unSentLogStatusList.map((element) => _getIndexKey(element.keyId!)).toSet();
    if (unsentLogIndexKeySet.isNotEmpty) {
      List<NgcLog> unsentLogs = await NgcLogRepo.instance.getLogsByIndexKeySet(unsentLogIndexKeySet);
      return (unSentLogStatusList, unsentLogs);
    }
    return (<NgcLogStatus>[], <NgcLog>[]);
  }

  String _getIndexKey(String keyId) => keyId.split("_")[0];
}
//
// class LogRepo {
//   Database? _db;
//
//   // final IBase view;
//   Function? onChangeTextProgress;
//
//   LogRepo({this.onChangeTextProgress});
//
//   Future<Database> get db async {
//     if (_db == null) {
//       DbLogHelper dbHelper = DbLogHelper.instance;
//       _db = await dbHelper.db;
//     }
//     return _db!;
//   }
//
//   final int LIMIT = 300;
//
//   Future<void> vacuum() async {
//     var dbClient = await db;
//     await dbClient.execute("VACUUM");
//   }
//
//   deleteDbLogsBefore30Days() async {
//     DateTime beforeTotalDays = DateTime.now().subtract(Duration(days: 14));
//     String dateTimeString = DateTimeUtil.getDateTimeForLog(beforeTotalDays);
//     String query = "DELETE FROM Log WHERE dateTime<=?";
//     var dbClient = await db;
//     int count = await dbClient.rawDelete(query, [dateTimeString]);
//     Log.i("$count row deleted from Log Table");
//   }
//
//   Future<bool> exportLogLastWeek() async {
//     return await exportLogsByLastDays(7);
//   }
//
//   Future<bool> exportLogLastMonth() async {
//     return await exportLogsByLastDays(60);
//   }
//
//   Future<bool> exportLogsByLastDays(int days) async {
//     List<LogModel> logs = await _getLogsLastByDay(days);
//     String pathFile = await _getPathFile();
//     bool isSuccess = await _createFile(pathFile, logs);
//     return isSuccess;
//   }
//
//   Future<List<LogModel>> _getLogsLastByDay(int days) async {
//     var dbClient = await db;
//     // String orgCode = Util.selectedOrgCode;
//     DateTime beforeAWeek = DateTime.now().subtract(Duration(days: days));
//     String dateTimeString = DateTimeUtil.getDateTimeForLog(beforeAWeek);
//     String query =
//         "SELECT * FROM Log WHERE dateTime >= ? ORDER BY dateTime ASC, mobileId ASC";
//     // String query = "SELECT * FROM Log WHERE dateTime >= ? AND orgCode = ? AND version = ? ORDER BY dateTime ASC, mobileId ASC";
//     var result = await dbClient.rawQuery(query, [dateTimeString]);
//     // var result = await dbClient.rawQuery(query, [dateTimeString, orgCode, currentVersion]);
//     if (result != null && result.length > 0) {
//       List<LogModel> list = result.map((e) => fromMap(e)).toList();
//       return list;
//     }
//     return [];
//   }
//
//   Future<bool> _createFile(String pathFile, List<LogModel> logs) async {
//     try {
//       StringBuffer buffer = StringBuffer();
//       buffer.write("DeviceId = ${Util.deviceId}\n\n");
//
//       final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//       if (Platform.isAndroid) {
//         var packageInfo = await PackageInfo.fromPlatform();
//         var currentVersion = packageInfo.version;
//         var xx = await deviceInfoPlugin.androidInfo;
//         // buffer.write("OrgCode = ${Util.selectedOrgCode}\n");
//         // buffer.write("Selected Location = ${Util.selectedUriInfo?.title}\n");
//         buffer.write("Version = ${xx.version.release}\n");
//         buffer.write("Version Sdk No = ${xx.version.sdkInt}\n");
//         buffer.write("Model = ${xx.model}\n");
//         buffer.write("Device = ${xx.device}\n");
//         buffer.write("isPhysicalDevice = ${xx.isPhysicalDevice}\n\n");
//
//         buffer.write("AppVersion: ${currentVersion}\n");
//         buffer.write("\n\n\n");
//       }
//       if (logs != null && logs.length > 0) {
//         for (var i = 0; i < logs.length; i++) {
//           buffer.write(logs[i]);
//           buffer.write("\n");
//         }
//       }
//       File file = File(pathFile);
//       await file.writeAsString(buffer.toString());
//       var isExist = await file.exists();
//       if (isExist) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       Log.e(error: e);
//       print(e);
//       return false;
//     }
//   }
//
//   Future<List> exportLog2() async {
//     int count = await getCountLogsLastWeek();
//     int pieces;
//     int mod = count % LIMIT;
//     if (mod > 0) {
//       pieces = ((count - mod) / LIMIT).round() + 1;
//     } else {
//       pieces = (count / LIMIT).round();
//     }
//     String pathFile = await _getPathFile();
//     File file = File(pathFile);
//     await _printInfoToFile(file);
//     List errorList = [];
//     for (int i = 0; i < pieces; i++) {
//       try {
//         if (onChangeTextProgress != null) {
//           onChangeTextProgress!("Downloading Logs  $i/$pieces");
//         }
//         int offset = i * LIMIT;
//         List<LogModel> logs = await _getLogsLastWeek2(offset);
//         bool isSuccess = await _printLogToFile(file, logs);
//         if (isSuccess) {
//           logs = [];
//           int x = 0;
//         }
//       } catch (e) {
//         errorList.add(e);
//         Log.e(error: e);
//       }
//     }
//     return errorList;
//   }
//
//   Future<int> getCountLogsLastWeek() async {
//     var dbClient = await db;
//     // String orgCode = Util.selectedOrgCode;
//     DateTime beforeAWeek = DateTime.now().subtract(Duration(days: 7));
//     String dateTimeString = DateTimeUtil.getDateTimeForLog(beforeAWeek);
//     String query =
//         "SELECT count(*) as countLogs FROM Log WHERE dateTime >= ? ORDER BY dateTime ASC, mobileId ASC";
//     var result = await dbClient.rawQuery(query, [dateTimeString]);
//     if (result != null && result.length > 0) {
//       int count = result.first['countLogs'] as int;
//       return count;
//     }
//     return 0;
//   }
//
//   Future<List<LogModel>> _getLogsLastWeek2(int offset) async {
//     var dbClient = await db;
//     // String orgCode = Util.selectedOrgCode;
//     DateTime beforeAWeek = DateTime.now().subtract(Duration(days: 7));
//     String dateTimeString = DateTimeUtil.getDateTimeForLog(beforeAWeek);
//     String query =
//         "SELECT * FROM Log WHERE dateTime >= ? ORDER BY dateTime ASC, mobileId ASC LIMIT ?,?";
//     var result =
//         await dbClient.rawQuery(query, [dateTimeString, offset, LIMIT]);
//     if (result != null && result.length > 0) {
//       List<LogModel> list = result.map((e) => fromMap(e)).toList();
//       result = [];
//       return list;
//     }
//     return [];
//   }
//
//   @override
//   Future<List<LogModel>> getAll() async {
//     var dbClient = await db;
//     var result = await dbClient.query(tableName,
//         orderBy: "dateTime ASC, mobileId ASC",
//         where: "LENGTH(dateTime)<?",
//         whereArgs: [26]);
//     return result.map((data) => fromMap(data)).toList();
//   }
//
//   Future<bool> _printInfoToFile(File file) async {
//     try {
//       StringBuffer buffer = StringBuffer();
//       buffer.write("DeviceId = ${Util.deviceId}\n\n");
//
//       if (Platform.isAndroid) {
//         var xx = await DeviceInfoPlugin().androidInfo;
//         // buffer.write("OrgCode = ${Util.selectedOrgCode}\n");
//         // buffer.write("Selected Location = ${Util.selectedUriInfo?.title}\n");
//         buffer.write("Version = ${xx.version.release}\n");
//         buffer.write("Version Sdk No = ${xx.version.sdkInt}\n");
//         buffer.write("Model = ${xx.model}\n");
//         buffer.write("Device = ${xx.device}\n");
//         buffer.write("isPhysicalDevice = ${xx.isPhysicalDevice}\n\n");
//
//         var packageInfo = await PackageInfo.fromPlatform();
//         String currentVersion = packageInfo.version;
//         buffer.write("AppVersion: ${currentVersion}\n");
//         buffer.write("\n\n\n");
//         await file.writeAsString(buffer.toString());
//         var isExist = await file.exists();
//         if (isExist) {
//           return true;
//         }
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//     return false;
//   }
//
//   Future<bool> _printLogToFile(File file, List<LogModel> logs) async {
//     StringBuffer buffer = StringBuffer();
//
//     try {
//       if (logs != null && logs.length > 0) {
//         for (var i = 0; i < logs.length; i++) {
//           buffer.write(logs[i]);
//           buffer.write("\n");
//         }
//       }
//       // File file = File(pathFile);
//       await file.writeAsString(buffer.toString());
//       var isExist = await file.exists();
//       if (isExist) {
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
//
//   Future<String> _getPathFile() async {
//     String? directoryPath = await _pathDirectory;
//     String dateString = DateTimeUtil.dateStringForFileName(DateTime.now());
//     String name = "LOG_$dateString.txt";
//     String pathFile = "$directoryPath/$name";
//     return pathFile;
//   }
//
//   Future<String>? get _pathDirectory async {
//     return ExternalStorage.getExternalStoragePublicDirectory(
//         ExternalStorage.DIRECTORY_DOWNLOADS);
//     // List<Directory> directoryList = await getExternalStorageDirectories(type: StorageDirectory.downloads);
//     // Directory directory = directoryList?.first;
//     // return directory.path;
//   }
//
//   LogModel fromMap(Map<String, dynamic> map) {
//     LogModel t = logFromMap(map);
//     return t;
//   }
//
//   Future<int> add(LogModel log) async {
//     try {
//       if (log == null) return 0;
//       var dbClient = await db;
//       if (dbClient == null) return 0;
//       var map = logToJson(log);
//       var id = await dbClient.insert(tableName, map,
//           conflictAlgorithm: ConflictAlgorithm.fail);
//       // id ??= -1;
//       return id;
//     } catch (e) {
//       return -1;
//     }
//   }
//
//   @override
//   String get tableName {
//     return "Log";
//   }
// }
