import 'package:json_annotation/json_annotation.dart';
import 'package:log_tracking/src/enum/enum_device_type.dart';

import 'device_info.dart';
import 'log_info.dart';

part 'log_info_request.g.dart';

/// Device details plus the logs being sent to the server.
@JsonSerializable()
class LogInfoRequest extends DeviceInfo {
  /// Creates a request that carries [logList]
  LogInfoRequest({
    this.logList,
    EnumDeviceType? type,
    super.versionSdkInt,
    super.model,
    super.brand,
    super.deviceId,
    super.appVersion,
    required super.isPhysicalDevice,
  }) : super(deviceType: type);

  /// Logs included in this request
  List<LogInfo>? logList;

  // LogInfoRequest({required bool isPhysicalDevice}) : super(isPhysicalDevice: isPhysicalDevice);

  /// Creates a request from JSON
  factory LogInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$LogInfoRequestFromJson(json);

  /// Converts this request to JSON
  Map<String, dynamic> toJson() => _$LogInfoRequestToJson(this);
}
