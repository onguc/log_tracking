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

  static Future<void> e({
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
    String stackTrace = StackTrace.current.toString();
    int index = stackTrace.indexOf("#2") + 8;
    var substring1 = stackTrace.toString().substring(index);
    int index2 = substring1.indexOf(" (");
    var substring2 = substring1.substring(0, index2);
    var list = substring2.split(".");
    var val = list[0];
    log.className =  val.substring(val.indexOf(" ")+1,val.length);
    log.methodName = list.length == 1 ? list[0] : list[1];
  }
}
