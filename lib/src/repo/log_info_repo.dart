import 'package:log_db/log_db.dart';
import 'package:log_tracking/src/repo/key_value_repo.dart';

import '../../log_tracking.dart';
import '../enum/enum_status.dart';
import '../model/log_info.dart';

/// Asıl logların kaydedilip yönetildiği yerdir
class LogInfoRepo {
  static LogInfoRepo? _instance;

  static LogInfoRepo get instance {
    _instance ??= LogInfoRepo._();
    return _instance!;
  }

  static late final LogManager db;

  static Future<void> init({required bool saveToLocal}) async {
    // var path = await _createFolderIfNotExists();

    db = await LogManager.open(saveToLocal); 
  }

  LogInfoRepo._();

  Future<void> save(LogInfo t) {
    if (t.id == null) {
      var repo = KeyValueRepo.instance;
      t.launchIndex = repo.appLaunchIndex;
      t.errorIndex = repo.errorIndex;
      return db.insertLog(toMap(t));
    } else {
      return Future.value(null);
    }
  }

  updateAll(List<LogInfo> loginfos) {
    //todo doldurulmalı
    db.updateUnsentToSent();
  }

  toMap(LogInfo log) {
    return {
      'id': log.id,
      'launchIndex': log.launchIndex,
      'errorIndex': log.errorIndex,
      'className': log.className,
      'methodName': log.methodName,
      'text': log.text,
      'dateTime': log.dateTime?.toIso8601String(),
      'timeZone': log.timeZone,
      'logType': log.logType?.name,
      'errorString': log.errorString,
      'stacktraceString': log.stacktraceString,
      'version': log.version,
      'logLevel': log.logLevel?.name,
      'logTypeGroup': log.logTypeGroup?.name,
      'status': log.status?.name,
      'groupId': log.groupId,
    };
  }

  LogInfo _fromMap(Map<String, dynamic> json) {
    final log = LogInfo(className: json['className']);
    log.id = json['id'];
    log.launchIndex = json['launchIndex'];
    log.errorIndex = json['errorIndex'];
    log.methodName = json['methodName'];
    log.text = json['text'];
    log.dateTime = json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null;
    log.timeZone = json['timeZone'];
    // Enum dönüşümlerini burada yapmanız gerekecek
    // log.logType = EnumLogType.values.firstWhere((e) => e.toString() == json['logType']);
    log.errorString = json['errorString'];
    log.stacktraceString = json['stacktraceString'];
    log.version = json['version'];
    // log.status = EnumStatus.values.firstWhere((e) => e.toString() == json['status']);
    log.groupId = json['groupId'];
    return log;
  }

  bool _isEnteredInDeleteMethode = false;

  /// 7 gün önceki logları siler.
  Future<int?> deleteLogsFrom7DaysAgo() async {
    if (!_isEnteredInDeleteMethode) {
      try {
        _isEnteredInDeleteMethode = true;
        int count = await db.deleteLogsSent7DaysEgo();
        return count;
      } on Exception catch (e) {
        _isEnteredInDeleteMethode = false;
        Log.e(e);
      }
    }
    return null;
  }

  Future<List<LogInfo>> getUnsentLogs() async {
    var mapList = await db.getLogsByStatus(EnumStatus.unsent.name);
    var list = mapList.map((e) => _fromMap(e)).toList();
    return list;
  }

  Future<List<LogInfo>> getUnsentLogByErrorIndex(int errorIndex) async {
    var mapList = await db.getUnsentLogByErrorIndex(errorIndex);
    var list = mapList.map((e) => _fromMap(e)).toList();
    return list;
  }

  Future<void> close() {
    return Future.value(null);
  }
}
