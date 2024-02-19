part of log_tracking;

/// Created by İrfan Öngüç
/// on 14 October 2020

class Log {
  Log._() {
    if (kDebugMode)
      logTypeGroup = EnumLogTypeGroup.DEBUG;
    else
      logTypeGroup = EnumLogTypeGroup.PRODUCTION;
  }

  PackageInfo? _packageInfo;
  Function(NgcLog val)? _onInfo;
  Function(NgcLog val)? _onError;
  Function(NgcLog val)? _onWarning;
  bool Function(Map<String, dynamic> request)? _onSendToServer;
  late EnumLogTypeGroup logTypeGroup;

  static late Log _instanse;

  static Future<void> init({
    bool saveToLocal = false,
    required Function(NgcLog val) onError,
    Function(NgcLog val)? onWarning,
    Function(NgcLog val)? onInfo,
    bool Function(Map<String, dynamic> request)? onSendToServer,
  }) async {
    bool sendToServer = onSendToServer != null;
    assert(!(sendToServer && !saveToLocal), 'The url cannot be full when the saveToLocal is false');
    await Isar.open(
      name: "taltal_db",
      [],
      inspector: true,
      directory: "directory.path",
    );
    _instanse = Log._();
    _instanse._onInfo = onInfo ?? (log) {};
    _instanse._onError = onError;
    _instanse._onWarning = onWarning ?? (log) {};
    _instanse._onSendToServer = onSendToServer ?? (request) => false;

    if (sendToServer) {
      checkConnectivity();
    }
    _instanse._packageInfo = await PackageInfo.fromPlatform();
    await DeviceInfo.init(_instanse._packageInfo!.version);

    if (saveToLocal) {
      await Hive.initFlutter();
      await NgcLogRepo.instance.initHive();
      await NgcLogStatusRepo.initHive();
      await IndexRepo.initHive();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        IndexRepo.instance.increaseAppStartupIndex();
        if (sendToServer) {
          isOnlineNotifier.addListener(() async {
            try {
              print("deneme");
              var isOnline = isOnlineNotifier.value;
              if (isOnline) {
                var (unsentLogStatusses, unsentLogs) = await LogRepo().getUnsentLogs();
                LogInfoRequest request = _instanse._getLogInfoRequest(unsentLogs);
                _instanse._updateNgcLogStatuses(unsentLogStatusses, EnumStatus.SENDING);
                bool isSentSuccess = await _instanse._onSendToServer!(request.toJson());
                if (isSentSuccess) {
                  await _instanse._deleteLogs(unsentLogStatusses, unsentLogs);
                  await NgcLogRepo.instance.deleteLogsFrom7DaysAgo();
                } else {
                  Log.w("log sending is not successful");
                  _instanse._updateNgcLogStatuses(unsentLogStatusses, EnumStatus.UNSENT);
                }
              }
            } catch (e) {
              Log.e(e);
            }
          });
        }
      });
    }
  }

  Future<void> _deleteLogs(List<NgcLogStatus> logStatuses, List<NgcLog> logList) async {
    var logStatusKeys = logStatuses.map((e) => e.keyId);
    var logKeys = logList.map((e) => e.keyId);
    await NgcLogStatusRepo.instance.deleteAllByKeys(logStatusKeys);
    await NgcLogRepo.instance.deleteAllByKeys(logKeys);
  }

  Future<void> _updateNgcLogStatuses(List<NgcLogStatus> logStatuses, EnumStatus enumStatus) async {
    for (NgcLogStatus logStatus in logStatuses) {
      logStatus.enumStatus = enumStatus;
      // NgcLogStatusRepo.instance.save(logStatus);
      logStatus.save();
    }
  }

  LogInfoRequest _getLogInfoRequest(List<NgcLog> logList) {
    DeviceInfo deviceInfo = DeviceInfo.instance;
    LogInfoRequest request = LogInfoRequest(
      isPhysicalDevice: deviceInfo.isPhysicalDevice,
      type: deviceInfo.deviceType,
      versionSdkInt: deviceInfo.versionSdkInt,
      model: deviceInfo.model,
      brand: deviceInfo.brand,
      deviceId: deviceInfo.deviceId,
      appVersion: deviceInfo.appVersion,
      logList: logList,
    );
    return request;
  }

  static Future<void> i(String text) async {
    try {
      NgcLog log = _instanse._newLog(EnumLogType.INFO, text);
      _instanse._printLog(log);
      _instanse._onInfo!(log);
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
      try {
        var current = StackTrace.current.toString();
        stack = _getStack(current);
      } catch (e) {
        stack = null;
      }
    }
    log.error = error;
    log.stackTrace = stack;
    if (!kIsWeb) {
      await _instanse._save(log);
      _instanse._onError!(log);
      List<NgcLog> unsentLogs = await NgcLogRepo.instance.getLastLogsByErrorLogKeyId(log.keyId!);

      // _instanse._onSendToServer!();
    }
    _instanse._printLog(log);
  }

  static Future<void> w(String text) async {
    NgcLog log = _instanse._newLog(EnumLogType.WARNING, text);
    _instanse._printLog(log);

    var current = StackTrace.current.toString();
    var previusStack = _getStack(current);
    log.stackTrace = previusStack;
    _instanse._onWarning!(log);
    // await _save(log);
  }

  static Future<void> d(String text) async {
    NgcLog log = _instanse._newLog(EnumLogType.DEBUG, text);
    log.logType = EnumLogType.WARNING;
    var current = StackTrace.current.toString();
    var previusStack = _getStack(current);
    log.stackTrace = previusStack;
    _instanse._printLog(log);
  }

  static StackTrace? _getStack(String current) {
    var currentNew;
    if (kIsWeb) {
      currentNew = current.split("\n").skip(5).join("\n");
    } else {
      currentNew = current.substring(current.indexOf("#1"));
    }
    return StackTrace.fromString(currentNew);
  }

  NgcLog _newLog(EnumLogType logType, String? text) {
    var log = NgcLog();
    log.logType = logType;
    log.text = text;
    log.version = DeviceInfo.instance.appVersion;
    log.logTypeGroup = logTypeGroup;
    _setClassAndMethodName(log);
    return log;
  }

  void _printLog(NgcLog log1) {
    try {
      if (kIsWeb) {
        print(log1.toString());
      } else if (Platform.isIOS || Platform.isMacOS)
        print(log1.toStringForIos());
      else {
        print(log1.toStringWithColorCode());
      }
    } catch (e) {
      print(log1.toString());
    }
  }

  Future<void> _save(NgcLog log) async {
    if (!kIsWeb) await NgcLogRepo.instance.save(log);
  }

  void _setClassAndMethodName(NgcLog log) {
    String stackTrace = StackTrace.current.toString();
    try {
      if (kIsWeb) {
        var appName = _instanse._packageInfo?.appName;
        if (StringUtil.isEmpty(appName)) {
          var row = stackTrace.split("\n")[7];
          var methodName = row.split(" ").last;
          var className = row.split("/").last.split(" ").first;
          log.className = className;
          log.methodName = methodName;
        } else {
          var index = stackTrace.indexOf(appName!);
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
    } catch (e) {
      int x = 0;
    }
  }

  close() async {
    await NgcLogRepo.instance.close();
    await NgcLogStatusRepo.instance.close();
  }
}
