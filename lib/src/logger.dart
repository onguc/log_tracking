import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:log_tracking/src/enum/enum_log_level.dart';
import 'package:log_tracking/src/enum/enum_log_type.dart';
import 'package:log_tracking/src/enum/enum_log_type_group.dart';
import 'package:log_tracking/src/model/device_info.dart';
import 'package:log_tracking/src/model/log_info.dart';
import 'package:log_tracking/src/model/log_info_request.dart';
import 'package:log_tracking/src/repo/log_info_repo.dart';
import 'package:log_tracking/src/utils/app_info.dart';
import 'package:log_tracking/src/utils/connectivity.dart';
import 'package:log_tracking/src/utils/string_util.dart';

/// This is the class that will be called in the project that contains Error(Log.e), Warning(Log.w), Information(Log.i), and Debug(Log.d) methods
class Log {
  Log._({
    bool saveToLocal = true,
    Function(LogInfo val)? onInfo,
    Function(LogInfo val)? onWarning,
    Function(LogInfo val)? onError,
    Function(LogInfo val)? onDebug,
    Future<bool> Function(LogInfoRequest request)? onSendToServer,
  }) {
    _saveToLocal = saveToLocal;
    _onInfo = onInfo;
    _onWarning = onWarning;
    _onError = onError;
    _onDebug = onDebug;
    _onSendToServer = onSendToServer;
    if (kDebugMode) {
      logTypeGroup = EnumLogTypeGroup.debug;
    } else {
      logTypeGroup = EnumLogTypeGroup.production;
    }
  }

  AppInfo? _packageInfo;

  /// Triggered when Log.i(...) method is called
  Function(LogInfo val)? _onInfo;

  /// Triggered when Log.e(...) method is called
  Function(LogInfo val)? _onError;

  /// Triggered when Log.w(...) method is called
  Function(LogInfo val)? _onWarning;

  Function(LogInfo val)? _onDebug;

  /// This method is triggered with the logs that have not been sent to the server after each error occurs.
  Future<bool> Function(LogInfoRequest request)? _onSendToServer;

  /// Which logs are kept in release builds: only production, or all
  late EnumLogTypeGroup logTypeGroup;

  late bool _saveToLocal;

  /// True while unsent logs are being sent, so only one send runs at a time
  bool _isSending = false;

  static Log? _instance;

  ///  Start log_tracking by calling this method in the main method
  static Future<bool> init({
    bool saveToLocal = false,
    Function(LogInfo val)? onWarning,
    Function(LogInfo val)? onInfo,
    Function(LogInfo val)? onDebug,
    required Function(LogInfo val) onError,
    Future<bool> Function(LogInfoRequest request)? onSendToServer,
  }) async {
    if (_instance != null) return true;
    bool isCanSentToServer = onSendToServer != null;
    assert(!(isCanSentToServer && !saveToLocal),
        'onSendToServer requires saveToLocal to be true');
    // Local storage is file based and not available on web
    bool useLocalStorage = saveToLocal && !kIsWeb;
    var instance = Log._(
      saveToLocal: useLocalStorage,
      onInfo: onInfo,
      onError: onError,
      onWarning: onWarning,
      onDebug: onDebug,
      onSendToServer: onSendToServer,
    );
    _instance = instance;

    bool isSuccess = true;
    try {
      instance._packageInfo = await AppInfo.read();
      await DeviceInfo.init(instance._packageInfo!.version);
    } catch (e) {
      isSuccess = false;
      _debugPrint(e);
    }

    if (useLocalStorage) {
      // Never throws; logs written in the meantime wait for it
      await LogInfoRepo.instance.init();
      if (isCanSentToServer) {
        listenConnectivity(() => instance._sendUnsentLogs());
      }
    } else {
      LogInfoRepo.instance.disable();
    }
    return isSuccess;
  }

  /// We print the Info logs with this method
  /// It is sent to the remote server together with the Log.e(...) method
  static Future<void> i(String text) async {
    try {
      assert(_instance != null, "_instanse can not be null!");
      LogInfo log = _instance!._newLog(EnumLogType.info, text);
      _instance!._printLog(log);
      _notify(_instance!._onInfo, log);
      await _instance!._save(log);
    } catch (e, s) {
      _debugPrint("$e \n$s");
    }
  }

  /// When Exceptions and Errors appear, we can log them with this method.
  /// If there is an Internet connection, it is instantly sent to the remote server along with the previous info and warning logs. Or it will be sent together with the first internet connection
  static Future<void> e(dynamic error,
      {StackTrace? stack,
      EnumLogLevel? logLevel = EnumLogLevel.medium,
      String? message}) async {
    try {
      assert(_instance != null, "_instanse can not be null!");
      LogInfo log = _instance!._newLog(EnumLogType.error, message);
      log.logType = EnumLogType.error;
      log.logLevel = logLevel;
      if (stack == null) {
        if (error is Error) {
          stack = error.stackTrace;
        } else {
          try {
            var current = StackTrace.current.toString();
            stack = _getStack(current);
          } catch (e) {
            stack = null;
          }
        }
      }
      log.error = error;
      log.stackTrace = stack;
      log.stacktraceString = stack?.toString();
      _instance!._printLog(log);
      // Third-party reporting never waits for local storage
      _notify(_instance!._onError, log);
      if (_instance!._saveToLocal) {
        await _instance!._save(log);
        await LogInfoRepo.instance.increaseErrorIndex();
        unawaited(_instance!._sendUnsentLogs());
      }
    } catch (e, s) {
      _debugPrint("$e \n$s");
    }
  }

  /// we print logs that are not errors, but have the nature of warnings, using this method.
  /// It is sent to the remote server together with the Log.e(...) method
  static Future<void> w(String text) async {
    try {
      assert(_instance != null, "_instanse can not be null!");
      LogInfo log = _instance!._newLog(EnumLogType.warning, text);
      _instance!._printLog(log);
      _notify(_instance!._onWarning, log);
      await _instance!._save(log);
    } catch (e, s) {
      _debugPrint("$e \n$s");
    }
  }

  /// With this method, we print the logs in debug mode. These logs are not sent to the server or to third-party libraries
  static Future<void> d(String text) async {
    try {
      assert(_instance != null, "_instanse can not be null!");
      LogInfo log = _instance!._newLog(EnumLogType.debug, text);
      log.logType = EnumLogType.debug;
      var current = StackTrace.current.toString();
      var previusStack = _getStack(current);
      log.stackTrace = previusStack;
      _instance!._printLog(log);
      _notify(_instance!._onDebug, log);
    } catch (e, s) {
      _debugPrint("$e \n$s");
    }
  }

  /// Sends unsent logs in batches; a failed batch stays unsent and is retried later
  Future<void> _sendUnsentLogs() async {
    var onSendToServer = _onSendToServer;
    if (_isSending || onSendToServer == null || !_saveToLocal) return;
    _isSending = true;
    try {
      while (true) {
        var batch = await LogInfoRepo.instance.getUnsentLogs();
        if (batch.end == null) break;
        // A batch made only of unreadable lines is skipped without a request
        if (batch.logs.isNotEmpty) {
          bool isSentSuccess =
              await onSendToServer(_getLogInfoRequest(batch.logs));
          if (!isSentSuccess) break;
        }
        await LogInfoRepo.instance.markSent(batch);
        if (!batch.hasMore) break;
      }
    } catch (e, s) {
      _debugPrint("$e \n$s");
    } finally {
      _isSending = false;
    }
  }

  /// Calls a user callback without letting its exception escape
  static void _notify(Function(LogInfo val)? callback, LogInfo log) {
    try {
      callback?.call(log);
    } catch (e, s) {
      _debugPrint("$e \n$s");
    }
  }

  static void _debugPrint(Object e) {
    if (kDebugMode) {
      // ignore: avoid_print
      print(e);
    }
  }

  LogInfoRequest _getLogInfoRequest(List<LogInfo> logList) {
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

  static StackTrace? _getStack(String current) {
    String currentNew;
    if (kIsWeb) {
      currentNew = current.split("\n").skip(5).join("\n");
    } else {
      currentNew = current.substring(current.indexOf("#1"));
    }
    return StackTrace.fromString(currentNew);
  }

  LogInfo _newLog(EnumLogType logType, String? text) {
    var log = LogInfo();
    log.logType = logType;
    log.text = text;
    log.version = DeviceInfo.instance.appVersion;
    log.logTypeGroup = logTypeGroup;
    _setClassAndMethodName(log);
    return log;
  }

  void _printLog(LogInfo log) {
    if (kDebugMode) {
      try {
        if (kIsWeb) {
          // ignore: avoid_print
          print(log.toString());
        } else if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          // ignore: avoid_print
          print(log.toStringForIos());
        } else {
          // ignore: avoid_print
          print(log.toStringWithColorCode());
        }
      } catch (e) {
        // ignore: avoid_print
        print(log.toString());
      }
    }
  }

  Future<void> _save(LogInfo log) async {
    if (_saveToLocal) await LogInfoRepo.instance.save(log);
  }

  void _setClassAndMethodName(LogInfo log) {
    String stackTrace = StackTrace.current.toString();
    try {
      if (kIsWeb) {
        var appName = _instance!._packageInfo?.appName;
        if (appName.isEmpty) {
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
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  /// Releases local storage resources. Call it only when logging is no longer needed.
  Future<void> close() async {
    await LogInfoRepo.instance.close();
  }
}
