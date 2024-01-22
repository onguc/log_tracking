import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:log_tracking/src/utils/string_util.dart';

import '../log_tracking.dart';
import 'enum/enum_log_type.dart';
import 'enum/enum_status.dart';
import 'model/base_response.dart';
import 'model/device_info.dart';
import 'model/log_info_request.dart';
import 'model/log_info_response.dart';
import 'model/ngc_log.dart';
import 'model/ngc_log_status.dart';
import 'repo/ngc_log_repo.dart';
import 'repo/ngc_log_status_repo.dart';
import 'utils/connectivity.dart';

/// Created by İrfan Öngüç
/// on 22.04.2022

class LogService {
  static LogService? _instance;

  static LogService createInstance(String url) {
    if (_instance == null) _instance = LogService._(url);
    return _instance!;
  }

  late Dio _dio;

  // String? _url;

  LogService._(String url) {
    HttpOverrides.global = LogHttpOverrides();
    _dio = createDioInstance(url);
  }

  Future<BaseResponse?> sendErrorLog(NgcLog log) async {
    // assert(StringUtil.isNotEmpty(_url), "Url can not be empty!");
    var response = await _dio.post('', data: log.toJson());

    return LogInfoResponse.fromJson(response.data);
  }

  Future<bool> sendLogList(List<NgcLog> logList, {List<NgcLogStatus>? logStatuses}) async {
    // assert(StringUtil.isNotEmpty(url), "Url can not be empty!");
    bool? isOnline = isOnlineNotifier.value;
    if (!isOnline) return false;

    if (logStatuses == null) {
      Iterable<String> keys = logList.where((element) => element.logType == EnumLogType.ERROR).map((e) => e.keyId!);
      logStatuses = NgcLogStatusRepo.instance.getAllByKeys(keys).toList();
    }

    LogInfoRequest request = _getLogInfoRequest(logList);
    _updateNgcLogStatuses(logStatuses, EnumStatus.SENDING);

    try {
      var response = await _dio.post('', data: request.toJson());
      var result = LogInfoResponse.fromJson(response.data);
      if (result.result == true) {
        Log.i("log sending successful");
        await _deleteLogs(logStatuses, logList);
        return true;
      } else {
        Log.w("log sending is not successful");
        _updateNgcLogStatuses(logStatuses, EnumStatus.UNSENT);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _deleteLogs(List<NgcLogStatus> logStatuses, List<NgcLog> logList) async {
    var logStatusKeys = logStatuses.map((e) => e.keyId);
    var logKeys = logList.map((e) => e.keyId);
    await NgcLogStatusRepo.instance.deleteAllByKeys(logStatusKeys);
    await NgcLogRepo.instance.deleteAllByKeys(logKeys);
  }

  LogInfoRequest _getLogInfoRequest(List<NgcLog> logList) {
    DeviceInfo deviceInfo = DeviceInfo.instance;
    LogInfoRequest? request = LogInfoRequest(
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

  Future<bool> sendAllLogs() async {
    List<NgcLogStatus> logStatuses = NgcLogStatusRepo.instance.getLogStatusesUnsent().toList();
    if (logStatuses.isEmpty) return false;
    Set<String> unsentLogIndexKeySet = logStatuses.map((element) => _getIndexKey(element.keyId!)).toSet();
    if (unsentLogIndexKeySet.isNotEmpty) {
      List<NgcLog> unsentLogs = await NgcLogRepo.instance.getLogsByIndexKeySet(unsentLogIndexKeySet);
      if (unsentLogs.isNotEmpty) {
        return await sendLogList(unsentLogs, logStatuses: logStatuses);
      }
    }
    return false;
  }

  Future<void> _updateNgcLogStatuses(List<NgcLogStatus> logStatuses, EnumStatus enumStatus) async {
    for (NgcLogStatus logStatus in logStatuses) {
      logStatus.enumStatus = enumStatus;
      NgcLogStatusRepo.instance.save(logStatus);
      logStatus.save();
    }
  }

  String _getIndexKey(String keyId) => keyId.split("_")[0];

  Dio createDioInstance(url) {
    assert(StringUtil.isNotEmpty(url), "Url can not be empty!");
    var deviceInfo = DeviceInfo.instance;
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: url ?? '',
        headers: {
          "content-type": "application/json",
          "device-type": deviceInfo.deviceType,
          "device-id": deviceInfo.deviceId,
          "app-version": deviceInfo.appVersion,
        },
      ),
    );

    if (defaultTargetPlatform == TargetPlatform.android) {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
          client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
          return client;
        },
      );

      // (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      //   return client;
      // };
    }

    return _dio;
    // return _dio;
  }
}

class LogHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        // final isValidHost = ["192.168.1.67"].contains(host);
        return true;
      });
  }
}
