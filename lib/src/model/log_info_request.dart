import 'package:json_annotation/json_annotation.dart';
import 'package:log_tracking/src/enum/enum_device_type.dart';

import 'device_info.dart';
import 'log_info.dart';

part 'log_info_request.g.dart';

/// Created by İrfan Öngüç
/// on 15.04.2022

@JsonSerializable()
class LogInfoRequest extends DeviceInfo {
  LogInfoRequest({
    this.logList,
    EnumDeviceType? type,
    versionSdkInt,
    model,
    brand,
    deviceId,
    appVersion,
    required isPhysicalDevice,
  }) : super(
          deviceType: type,
          versionSdkInt: versionSdkInt,
          model: model,
          brand: brand,
          deviceId: deviceId,
          appVersion: appVersion,
          isPhysicalDevice: isPhysicalDevice,
        );

  List<LogInfo>? logList;

  // LogInfoRequest({required bool isPhysicalDevice}) : super(isPhysicalDevice: isPhysicalDevice);

  factory LogInfoRequest.fromJson(Map<String, dynamic> json) => _$LogInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogInfoRequestToJson(this);
}
