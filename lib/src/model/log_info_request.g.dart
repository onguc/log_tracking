// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInfoRequest _$LogInfoRequestFromJson(Map<String, dynamic> json) => LogInfoRequest(
      logList: (json['logList'] as List<dynamic>?)?.map((e) => LogInfo.fromJson(e as Map<String, dynamic>)).toList(),
      versionSdkInt: json['versionSdkInt'],
      model: json['model'],
      brand: json['brand'],
      deviceId: json['deviceId'],
      appVersion: json['appVersion'],
      isPhysicalDevice: json['isPhysicalDevice'],
    )
      ..deviceType = $enumDecodeNullable(_$EnumDeviceTypeEnumMap, json['deviceType'])
      ..appName = json['appName'] as String?;

Map<String, dynamic> _$LogInfoRequestToJson(LogInfoRequest instance) => <String, dynamic>{
      'deviceType': _$EnumDeviceTypeEnumMap[instance.deviceType],
      'versionSdkInt': instance.versionSdkInt,
      'model': instance.model,
      'brand': instance.brand,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'isPhysicalDevice': instance.isPhysicalDevice,
      'appName': instance.appName,
      'logList': instance.logList,
    };

const _$EnumDeviceTypeEnumMap = {
  EnumDeviceType.ANDROID: 'ANDROID',
  EnumDeviceType.IOS: 'IOS',
  EnumDeviceType.MACOS: 'MACOS',
  EnumDeviceType.LINUX: 'LINUX',
  EnumDeviceType.WINDOWS: 'WINDOWS',
  EnumDeviceType.WEB: 'WEB',
  EnumDeviceType.UNKNOWN: 'UNKNOWN',
};
