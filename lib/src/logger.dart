part of log_tracking;

/// Created by İrfan Öngüç
/// on 14 October 2020

class Log {
  Log._();

  PackageInfo? _packageInfo;
  Function(NgcLog val)? _onInfo;
  Function(NgcLog val)? _onError;
  Function(NgcLog val)? _onWarning;

  static late Log _instanse;

  static Future<void> init({
    String? url,
    bool saveToLocal = false,
    required Function(NgcLog val) onError,
    Function(NgcLog val)? onWarning,
    Function(NgcLog val)? onInfo,
  }) async {
    assert(!(url != null && url.isNotEmpty && !saveToLocal), 'The url cannot be full when the saveToLocal is false');

    _instanse = Log._();
    _instanse._onInfo = onInfo ?? (log) {};
    _instanse._onError = onError;
    _instanse._onWarning = onWarning ?? (log) {};
    checkConnectivity();

    _instanse._packageInfo = await PackageInfo.fromPlatform();
    await DeviceInfo.init(_instanse._packageInfo!.version);
    LogService.instance.url = url ?? "";
    if (saveToLocal) {
      await Hive.initFlutter();
      await NgcLogRepo.instance.initHive();
      await NgcLogStatusRepo.initHive();
      await IndexRepo.initHive();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        IndexRepo.instance.increaseAppStartupIndex();
        if (StringUtil.isEmpty(LogService.instance.url)) return;
        isOnlineNotifier.addListener(() async {
          try {
            var isOnline = isOnlineNotifier.value;
            if (isOnline) {
              var isSentSuccess = await LogService.instance.sendAllLogs();
              if (isSentSuccess) await NgcLogRepo.instance.deleteLogsFrom7DaysAgo();
            }
          } catch (e) {
            Log.e(e);
          }
        });
      });
    }
  }

  static Future<void> i(String text) async {
    try {
      NgcLog log = _instanse._newLog(EnumLogType.INFO, text);
      _instanse._printLog(log);
      if (kDebugMode) {
        log.logTypeGroup = EnumLogTypeGroup.DEBUG;
      } else {
        if (!kIsWeb) {
          log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
          _instanse._onInfo!(log);
          // FirebaseCrashlytics.instance.log(text);
        }
      }
      // await _save(log);
    } catch (e, s) {
      print("$e \n$s");
    }
  }

  static Future<void> e(dynamic error, {StackTrace? stack, EnumLogLevel? logLevel = EnumLogLevel.MEDIUM, String? message}) async {
    NgcLog log = _instanse._newLog(EnumLogType.ERROR, message);
    log.logType = EnumLogType.ERROR;
    log.logLevel = logLevel;
    if (stack != null) {
      log.stacktraceString = stack.toString();
    } else if (error is Error) {
      stack = error.stackTrace;
      log.stacktraceString = stack.toString();
    } else {
      var current = StackTrace.current.toString();
      log.stacktraceString = current.substring(current.indexOf("#1"));
      stack = StackTrace.fromString(log.stacktraceString!);
    }
    log.stackTrace = stack;
    if (kDebugMode) {
      log.logTypeGroup = EnumLogTypeGroup.DEBUG;
    } else {
      log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
      if (!kIsWeb) {
        _instanse._onError!(log);
        // var isCrashlyticsCollectionEnabled = FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
        // FirebaseCrashlytics.instance.recordFlutterError(
        //   FlutterErrorDetails(exception: error, stack: stack),
        //   fatal: true,
        // );
      }
    }

    log.error = error;
    _instanse._printLog(log);
  }

  static Future<void> w(String text) async {
    NgcLog log = _instanse._newLog(EnumLogType.WARNING, text);
    _instanse._printLog(log);
    if (kDebugMode) {
      log.logTypeGroup = EnumLogTypeGroup.DEBUG;
    } else {
      log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
      var current = StackTrace.current.toString();
      var currentNew = current.substring(current.indexOf("#1"));
      var previusStack = StackTrace.fromString(currentNew);
      log.stackTrace = previusStack;
      if (!kIsWeb) {
        _instanse._onWarning!(log);
        // FirebaseCrashlytics.instance.recordFlutterError(
        //   FlutterErrorDetails(
        //     exception: "WARNING:  $text}",
        //     stack: previusStack,
        //   ),
        //   fatal: true,
        // );
      }
    }
    // await _save(log);
  }

  static Future<void> d(String text) async {
    NgcLog log = _instanse._newLog(EnumLogType.DEBUG, text);
    log.logType = EnumLogType.WARNING;
    log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
    var current = StackTrace.current.toString();
    var currentNew = current.substring(current.indexOf("#1"));
    var previusStack = StackTrace.fromString(currentNew);
    log.stackTrace = previusStack;
    _instanse._printLog(log);
    if (!kIsWeb) {
      // FirebaseCrashlytics.instance.recordFlutterError(
      //   FlutterErrorDetails(
      //     exception: "WARNING:  $text}",
      //     stack: previusStack,
      //   ),
      //   fatal: true,
      // );
    }
    // await _save(log);
  }

  NgcLog _newLog(EnumLogType logType, String? text) {
    var log = NgcLog();
    log.logType = logType;
    log.text = text;
    log.version = DeviceInfo.instance.appVersion;
    _setClassAndMethodName(log);
    return log;
  }

  void _printLog(NgcLog log1) {
    if (Platform.isIOS || Platform.isMacOS)
      print(log1.toStringForIos());
    else if (kIsWeb) {
      print(log1.toString());
    } else {
      print(log1.toStringWithColorCode());
    }
  }

  Future<void> _save(NgcLog log) async {
    if (!kIsWeb) await NgcLogRepo.instance.save(log);
  }

  void _setClassAndMethodName(NgcLog log) {
    String stackTrace = StackTrace.current.toString();
    if (kIsWeb) {
      var appName = _instanse._packageInfo!.appName;
      var index = stackTrace.indexOf(appName);
      var substring1 = stackTrace.toString().substring(index);
      int index2 = substring1.indexOf('\n');
      var substring2 = substring1.substring(0, index2);
      var list = substring2.split("/");
      var val = list.last;
      var split = val.split(RegExp(r'\d+:\d+'));
      if (split.length == 2) {
        log.className = split[0];
        log.methodName = split[1];
      }
    } else {
      int index = stackTrace.indexOf("#3") + 8;
      var substring1 = stackTrace.toString().substring(index);
      int index2 = substring1.indexOf(" (");
      var substring2 = substring1.substring(0, index2);
      var list = substring2.split(".");
      var val = list[0];
      log.className = val.substring(val.indexOf(" ") + 1, val.length);
      log.methodName = list.length == 1 ? list[0] : list[1];
    }
  }

  close() async {
    await NgcLogRepo.instance.close();
    await NgcLogStatusRepo.instance.close();
  }
}
