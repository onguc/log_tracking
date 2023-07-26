part of log_tracking;

/// Created by İrfan Öngüç
/// on 14 October 2020

class Log {
  String className = "";
  static PackageInfo? packageInfo;

  Log(Type? type) {
    if (type != null) className = type.toString();
  }

  static Future<void> init(String url) async {
    packageInfo = await PackageInfo.fromPlatform();
    await DeviceInfo.init();
    LogService.url = url;
    await Hive.initFlutter();
    await NgcLogRepo.initHive();
    await NgcLogStatusRepo.initHive();
    await IndexRepo.initHive();
    // await xx.initializeDateFormatting('tr_TR',null);
    Future.delayed(Duration(seconds: 1)).then((value) async {
      IndexRepo.instance.increaseAppStartupIndex();
      if (LogService.url.isEmpty) return;
      isOnlineNotifier.addListener(() async {
        try {
          if (isOnlineNotifier.value == true) {
            var isSentSuccess = await LogService.instance.sendAllLogs();
            if (isSentSuccess) await NgcLogRepo.instance.deleteLogsFrom7DaysAgo();
          }
        } catch (e) {
          Log.e(e);
        }
      });
      print("logger.init içindeki işlem tamamlandı");
    });
  }

  static Future<void> i(String text) async {
    try {
      NgcLog log = _newLog(text);
      log.logType = EnumLogType.INFO;
      _printLog(log);
      if (kDebugMode) {
        log.logTypeGroup = EnumLogTypeGroup.DEBUG;
      } else {
        log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
        FirebaseCrashlytics.instance.log(text);
      }
      // await _save(log);
    } catch (e, s) {
      print("$e \n$s");
    }
  }

  static Future<void> e(dynamic error, {StackTrace? stack, EnumLogLevel? logLevel = EnumLogLevel.MEDIUM, String? message}) async {
    NgcLog log = _newLog(message);
    log.logType = EnumLogType.ERROR;
    log.logLevel = logLevel;
    if (kDebugMode) {
      log.logTypeGroup = EnumLogTypeGroup.DEBUG;
    } else {
      log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;

      var current = StackTrace.current.toString();
      var currentNew = current.substring(current.indexOf("#1"));
      var previusStack = StackTrace.fromString(currentNew);

      log.stacktraceString = currentNew;
      var isCrashlyticsCollectionEnabled = FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      FirebaseCrashlytics.instance.recordFlutterError(
        FlutterErrorDetails(exception: error, stack: previusStack),
        fatal: true,
      );
    }

    log.error = error;
    _printLog(log);

    // await _save(log);
    // NgcLogStatus ngcLogStatus = NgcLogStatus()
    //   ..enumStatus = EnumStatus.UNSENT
    //   ..keyId = log.keyId;
    // await NgcLogStatusRepo.instance.save(ngcLogStatus);
    // IndexRepo.instance.increaseAppErrorLogIndex();
    // List<NgcLog> lastLogList = await NgcLogRepo.instance.getLastLogsByErrorLogKeyId(log.keyId!);
    // if (LogService.url.isEmpty) return;
    // LogService.instance.sendLogList(lastLogList).catchError((error, stackTrace) {
    //   Log.e(error);
    // });
  }

  static Future<void> w(String text) async {
    NgcLog log = _newLog(text);
    log.logType = EnumLogType.WARNING;
    _printLog(log);
    if (kDebugMode) {
      log.logTypeGroup = EnumLogTypeGroup.DEBUG;
    } else {
      log.logTypeGroup = EnumLogTypeGroup.PRODUCTION;
      var current = StackTrace.current.toString();
      var currentNew = current.substring(current.indexOf("#1"));
      var previusStack = StackTrace.fromString(currentNew);
      FirebaseCrashlytics.instance.recordFlutterError(
        FlutterErrorDetails(
          exception: "WARNING:  $text}",
          stack: previusStack,
        ),
        fatal: true,
      );
    }
    // await _save(log);
  }

  static NgcLog _newLog(String? text) {
    var log = NgcLog();
    log.text = text;
    log.version = DeviceInfo.instance.appVersion;
    _setClassAndMethodName(log);
    return log;
  }

  static void _printLog(NgcLog log1) {
    if (Util.isCanPrintLog) {
      if (defaultTargetPlatform == TargetPlatform.iOS)
        print(log1.toStringForIos());
      else
        print(log1.toStringWithColorCode());
    }
  }

  static Future<void> _save(NgcLog log) async {
    if (Util.isCanPrintLog)
      // if(kReleaseMode) {
      await NgcLogRepo.instance.save(log);
    // }
  }

  static void _setClassAndMethodName(NgcLog log) {
    String stackTrace = StackTrace.current.toString();
    // print("\nstackTrace22 = ${stackTrace}");
    if (kIsWeb) {
      var appName = Log.packageInfo!.appName;
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

  static close() async {
    await NgcLogRepo.instance.close();
    await NgcLogStatusRepo.instance.close();
  }
}
