import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:log_tracking/src/enum/enum_log_level.dart';
import 'package:log_tracking/src/enum/enum_log_type.dart';
import 'package:log_tracking/src/enum/enum_log_type_group.dart';
import 'package:log_tracking/src/enum/enum_status.dart';
import 'package:log_tracking/src/model/device_info.dart';
import 'package:log_tracking/src/model/log_info.dart';
import 'package:log_tracking/src/model/log_info_request.dart';
import 'package:log_tracking/src/repo/base_repo.dart';
import 'package:log_tracking/src/repo/log_info_repo.dart';
import 'package:log_tracking/src/repo/singular_repo.dart';
import 'package:log_tracking/src/utils/connectivity.dart';
import 'package:log_tracking/src/utils/string_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Created by İrfan Öngüç
/// on 14 October 2020

class Log {
  Log._({
    bool saveToLocal = true,
    Function(LogInfo val)? onInfo,
    Function(LogInfo val)? onWarning,
    Function(LogInfo val)? onError,
    Future<bool> Function(LogInfoRequest request)? onSendToServer,
  }) {
    this._saveToLocal = saveToLocal;
    this._onInfo = onInfo;
    this._onWarning = onWarning;
    this._onError = onError;
    this._onSendToServer = onSendToServer;
    if (kDebugMode)
      logTypeGroup = EnumLogTypeGroup.DEBUG;
    else
      logTypeGroup = EnumLogTypeGroup.PRODUCTION;
  }

  PackageInfo? _packageInfo;

  /// Triggered when Log.i(...) method is called
  Function(LogInfo val)? _onInfo;

  /// Triggered when Log.e(...) method is called
  Function(LogInfo val)? _onError;

  /// Triggered when Log.w(...) method is called
  Function(LogInfo val)? _onWarning;

  /// This method is triggered with the logs that have not been sent to the server after each error occurs.
  Future<bool> Function(LogInfoRequest request)? _onSendToServer;
  late EnumLogTypeGroup logTypeGroup;
  late bool _saveToLocal;

  static Log? _instanse;

  static Future<void> init({
    bool saveToLocal = false,
    Function(LogInfo val)? onWarning,
    Function(LogInfo val)? onInfo,
    required Function(LogInfo val) onError,
    Future<bool> Function(LogInfoRequest request)? onSendToServer,
  }) async {
    if (_instanse != null) return;
    bool isCanSentToServer = onSendToServer != null;
    assert(!(isCanSentToServer && !saveToLocal), 'The url cannot be full when the saveToLocal is false');
    _instanse = Log._(
      saveToLocal: saveToLocal,
      onInfo: onInfo ?? (log) {},
      onError: onError,
      onWarning: onWarning ?? (log) {},
      onSendToServer: onSendToServer ?? (LogInfoRequest request) => Future.value(false),
    );
    if (isCanSentToServer) {
      checkConnectivity();
    }
    _instanse!._packageInfo = await PackageInfo.fromPlatform();
    await DeviceInfo.init(_instanse!._packageInfo!.version);

    if (saveToLocal) {
      await BaseRepo.init();
      SingularRepo.instance.increaseAppLaunchIndex();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        // IndexRepo.instance.increaseAppStartupIndex();
        if (isCanSentToServer) {
          isOnlineNotifier.addListener(() async {
            var isOnline = isOnlineNotifier.value;
            if (isOnline) {
              var unsentLogs = await LogInfoRepo.instance.getUnsentLogs();
              LogInfoRepo.instance;
              LogInfoRequest request = _instanse!._getLogInfoRequest(unsentLogs);
              try {
                await _instanse!._updateStatus(unsentLogs, EnumStatus.SENDING);
                bool isSentSuccess = await _instanse!._onSendToServer!(request);
                if (isSentSuccess) {
                  _instanse!._updateStatus(unsentLogs, EnumStatus.SENT);
                  await LogInfoRepo.instance.deleteLogsFrom7DaysAgo();
                } else {
                  Log.w("log sending is not successful");
                  _instanse!._updateStatus(unsentLogs, EnumStatus.UNSENT);
                }
              } catch (e) {
                Log.e(e);
                _instanse!._updateStatus(unsentLogs, EnumStatus.UNSENT);
              }
            }
          });
        }
      });
    }
  }

  static Future<void> i(String text) async {
    try {
      assert(_instanse != null, "_instanse can not be null!");
      LogInfo log = _instanse!._newLog(EnumLogType.INFO, text);
      _instanse!._printLog(log);
      _instanse!._onInfo!(log);
      await _instanse!._save(log);
    } catch (e, s) {
      print("$e \n$s");
    }
  }

  static Future<void> e(dynamic error, {StackTrace? stack, EnumLogLevel? logLevel = EnumLogLevel.MEDIUM, String? message}) async {
    assert(_instanse != null, "_instanse can not be null!");
    LogInfo log = _instanse!._newLog(EnumLogType.ERROR, message);
    log.logType = EnumLogType.ERROR;
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
    if (!kIsWeb) {
      await _instanse!._save(log);
      await SingularRepo.instance.increaseErrorIndex();
      _instanse!._onError!(log);
      List<LogInfo> unsentLogs = await LogInfoRepo.instance.getUnsentLogByErrorIndex(log.errorIndex!);
      LogInfoRequest request = _instanse!._getLogInfoRequest(unsentLogs);
      _instanse!._onSendToServer!(request);
    }
    _instanse!._printLog(log);
  }

  static Future<void> w(String text) async {
    assert(_instanse != null, "_instanse can not be null!");
    LogInfo log = _instanse!._newLog(EnumLogType.WARNING, text);
    _instanse!._printLog(log);

    var current = StackTrace.current.toString();
    var previusStack = _getStack(current);
    log.stackTrace = previusStack;
    _instanse!._onWarning!(log);
    await _instanse!._save(log);
  }

  static Future<void> d(String text) async {
    assert(_instanse != null, "_instanse can not be null!");
    LogInfo log = _instanse!._newLog(EnumLogType.DEBUG, text);
    log.logType = EnumLogType.WARNING;
    var current = StackTrace.current.toString();
    var previusStack = _getStack(current);
    log.stackTrace = previusStack;
    _instanse!._printLog(log);
  }

  Future<void> _updateStatus(List<LogInfo> logStatuses, EnumStatus enumStatus) async {
    if (_saveToLocal) {
      logStatuses.forEach((e) => e.status = enumStatus);
      await LogInfoRepo.instance.saveAll(logStatuses);
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
    var currentNew;
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
    try {
      if (kIsWeb) {
        print(log.toString());
      } else if (Platform.isIOS || Platform.isMacOS)
        print(log.toStringForIos());
      else {
        print(log.toStringWithColorCode());
      }
    } catch (e) {
      print(log.toString());
    }
  }

  Future<void> _save(LogInfo log) async {
    if (!kIsWeb && _saveToLocal) await LogInfoRepo.instance.save(log);
  }

  void _setClassAndMethodName(LogInfo log) {
    String stackTrace = StackTrace.current.toString();
    try {
      if (kIsWeb) {
        var appName = _instanse!._packageInfo?.appName;
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
    } catch (e) {}
  }

  close() async {
    await LogInfoRepo.instance.close();
  }
}
