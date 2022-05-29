import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../enum/enum_device_type.dart';

part 'device_info.g.dart';

/// Created by İrfan Öngüç
/// on 15.04.2022

@JsonSerializable()
class DeviceInfo {
  EnumDeviceType? deviceType;

  /// 30
  String? versionSdkInt;
  String? model;
  String? brand;
  String? deviceId;
  String? appVersion;
  bool isPhysicalDevice;

  DeviceInfo({
    this.deviceType,
    this.versionSdkInt,
    this.model,
    this.brand,
    this.deviceId,
    this.appVersion,
    required this.isPhysicalDevice,
  });

  static DeviceInfo? _instance;

  static DeviceInfo get instance {
    if (_instance == null) _instance = DeviceInfo(isPhysicalDevice: false);
    return _instance!;
  }

  // factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = await packageInfo.version;
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo; // deviceId: 48FFBBAC-B260-47C2-9B5F-BDB2EEF1D1A8
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.IOS,
        versionSdkInt: data.systemVersion,
        model: data.model,
        brand: "iphone",
        deviceId: data.identifierForVendor,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice,
      );
    } else if (Platform.isAndroid) {
      var data = await deviceInfoPlugin.androidInfo; // deviceId: 0696220404946b51
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.ANDROID,
        versionSdkInt: "${data.version.sdkInt}",
        model: data.model,
        brand: data.brand,
        deviceId: data.androidId,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice ?? false,
      );
    } else if (Platform.isMacOS) {
      var data = await deviceInfoPlugin.macOsInfo;
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.MACOS,
        model: data.model,
        brand: "macos",
        deviceId: data.systemGUID,
        appVersion: appVersion,
        isPhysicalDevice: true,
      );
    } else {
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.UNKNOWN,
        versionSdkInt: "1",
        model: "testModel",
        brand: "testBrand",
        deviceId: "TestDeviceId_123455",
        appVersion: appVersion,
        isPhysicalDevice: false,
      );
    }
  }
}
