part of log_tracking;

/// Created by İrfan Öngüç
/// on 14 October 2020

class Log {
  String className = "";
  static LogRepo logRepo = LogRepo();

  Log(Type? type) {
    if (type != null) className = type.toString();
  }

//test

  static Future<void> i(String text) async {
    var log = LogModel();
    _setClassAndMethodName(log);
    log.logType = EnumLogType.INFO;
    log.text = text;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    log.version = await Util.version;
    _printLog(log);
    await _save(log);
  }

  static Future<void> e(
      {
      String? message,
      dynamic error}) async {
    var log = LogModel();
    _setClassAndMethodName(log);
    if (StringUtil.isEmptyString(message)) message = "IN CATCH";
    log.logType = EnumLogType.ERROR;
    log.text = message;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    log.error = error;
    log.version = await Util.version;
    _printLog(log);
    await _save(log);
  }

  static Future<void> w(String text) async {
    var log = LogModel();
    _setClassAndMethodName(log);
    log.logType = EnumLogType.WARNING;
    log.text = text;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    log.version = await Util.version;
    _printLog(log);
    await _save(log);
  }

  static void _printLog(var log) {
    if (Util.isCanPrintLog) {
      print(log);
    }
  }

  static Future<void> _save(LogModel log) async {
    if (Util.isCanPrintLog)
      // if(kReleaseMode) {
      await logRepo.add(log);
    // }
  }

  static void _setClassAndMethodName(LogModel log) {
    DateTime dateTime = DateTime.now();
    String stackTrace = StackTrace.current.toString();
    int lastIndex = stackTrace.indexOf(" (file:");
    int firstIndex = stackTrace.indexOf("#2      ") + 8;
    var substring = stackTrace.toString().substring(firstIndex, lastIndex);
    var list = substring.split(".");
    log.className = list[0];
    log.methodName = list.length == 1 ? list[0] : list[1];
    var dateTime2 = DateTime.now();
    var compareTo = dateTime2.compareTo(dateTime);
    var i = dateTime2.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;
    print("toplam süre: $i");
  }
}
