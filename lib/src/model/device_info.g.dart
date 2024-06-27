// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      deviceType:
          $enumDecodeNullable(_$EnumDeviceTypeEnumMap, json['deviceType']),
      versionSdkInt: json['versionSdkInt'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      deviceId: json['deviceId'] as String?,
      appVersion: json['appVersion'] as String?,
      isPhysicalDevice: json['isPhysicalDevice'] as bool,
    )..appName = json['appName'] as String?;

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'deviceType': _$EnumDeviceTypeEnumMap[instance.deviceType],
      'versionSdkInt': instance.versionSdkInt,
      'model': instance.model,
      'brand': instance.brand,
      'deviceId': instance.deviceId,
      'appVersion': instance.appVersion,
      'isPhysicalDevice': instance.isPhysicalDevice,
      'appName': instance.appName,
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
