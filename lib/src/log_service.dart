import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

  static LogService get instance {
    if (_instance == null) _instance = LogService._();
    return _instance!;
  }

  late Dio dio;
  static late String url;

  // SessionManager get sessionManager => sl<SessionManager>();

  LogService._() {
    dio = dioInstance;
  }

  Future<BaseResponse> sendErrorLog(NgcLog log) async {
    var response = await dio.post(url, data: log.toJson());

    return LogInfoResponse.fromJson(response.data);
  }

  Future<bool> sendLogList(List<NgcLog> logList, {List<NgcLogStatus>? logStatuses}) async {
    bool? hasDataConnection = isOnlineNotifier.value;
    if (hasDataConnection != true) return false;

    if (logStatuses == null) {
      Iterable<String> keys = logList.where((element) => element.logType == EnumLogType.ERROR).map((e) => e.keyId!);
      logStatuses = NgcLogStatusRepo.instance.getAllByKeys(keys).toList();
    }

    LogInfoRequest request = _getLogInfoRequest(logList);
    _updateNgcLogStatuses(logStatuses, EnumStatus.SENDING);
    // dio.options.headers["content-type"]="application/octet-stream; charset=utf-8";

    try {
      var response = await dio.post(url, data: request.toJson());
      var result = LogInfoResponse.fromJson(response.data);
      if (result.result == true) {
        Log.i("log sending successful");
        // _updateNgcLogStatuses(logStatuses, EnumStatus.SENT);
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

  // Future<BaseResponse> gonderilmeyenleriGonder() async {
  //   NgcLogRepo logRepo = sl<NgcLogRepo>();
  //   List<NgcLog> list = await logRepo.getNotSendedList();
  //   return sendLogList(list);
  // }

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

  Dio get dioInstance {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: url,
        headers: {"content-type": "application/json", "device-type": DeviceInfo.instance.deviceType, "device-id": DeviceInfo.instance.deviceId, "app-version": DeviceInfo.instance.appVersion},
      ),
    );

    // final AuthenticateResult authenticate = sessionManager.sessionInfo?.authenticateResult;
    // if (authenticate != null) {
    //   final String token = authenticate.accessToken;

    //   _dio.options.headers.addAll({
    //     "Authorization": "bearer $token",
    //   });
    // }

    if (defaultTargetPlatform==TargetPlatform.android) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    return _dio;
    // return _dio;
  }
}
