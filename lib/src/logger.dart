part of log_tracking;

/// Created by İrfan Öngüç
/// on 14 October 2020

class Logger {
  String className = "";

  Logger(Type? type) {
    if (type != null) className = type.toString();
  }


//test

  Future<void> i(String text,
      {String? methodName, StackTrace? stackTrace}) async {
    var log = Log();
    log.logType = EnumLogType.INFO;
    log.methodName = methodName;
    log.text = text;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    log.stackTrace = stackTrace;
    log.version = await Util.version;
    print(log);
    await _save(log);
  }

  Future<void> e(
      {String? methodName,
      String? message,
      dynamic error,
      StackTrace? stackTrace}) async {
    var log = Log(className: className);
    if (StringUtil.isEmptyString(message)) message = "IN CATCH";
    log.logType = EnumLogType.ERROR;
    log.methodName = methodName;
    log.text = message;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    if (stackTrace != null) log.stackTrace = stackTrace;
    log.error = error;
    log.version = await Util.version;
    print(log);
    await _save(log);
  }

  Future<void> w(String text,
      {String? methodName, StackTrace? stackTrace}) async {
    var log = Log(className: className);
    log.logType = EnumLogType.WARNING;
    log.methodName = methodName;
    log.text = text;
    log.dateTime = DateTimeUtil.getDateTimeForLog(DateTime.now());
    log.stackTrace = stackTrace;
    log.version = await Util.version;
    print(log);
    await _save(log);
  }

  Future<void> _save(Log log) async {
    // if(kReleaseMode) {
    await LogRepo().add(log);
    // }
  }
}
