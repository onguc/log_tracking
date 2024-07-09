import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../enum/enum_device_type.dart';

class DeviceInfo {
  EnumDeviceType? deviceType;

  String? versionSdkInt;
  String? model;
  String? brand;
  String? deviceId;
  String? appVersion;
  bool isPhysicalDevice;
  String? appName;

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

  static Future<void> init(String appVersion) async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (kIsWeb) {
      var data = await deviceInfoPlugin.webBrowserInfo; // deviceId: 0696220404946b51
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.web,
        brand: data.browserName.name,
        appVersion: appVersion,
        isPhysicalDevice: true,
      );
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo; // deviceId: 48FFBBAC-B260-47C2-9B5F-BDB2EEF1D1A8
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.ios,
        versionSdkInt: data.systemVersion,
        model: data.model,
        brand: "iphone",
        deviceId: data.identifierForVendor,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice,
      );
    } else if (Platform.isAndroid) {
      var data = await deviceInfoPlugin.androidInfo; // deviceId: 0696220404946b51
      final String? androidId = await AndroidId().getId();
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.android,
        versionSdkInt: "${data.version.sdkInt}",
        model: data.model,
        brand: data.brand,
        deviceId: androidId,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice,
      );
    } else if (Platform.isMacOS) {
      var data = await deviceInfoPlugin.macOsInfo;
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.macos,
        model: data.model,
        brand: "macos",
        deviceId: data.systemGUID,
        appVersion: appVersion,
        isPhysicalDevice: true,
      );
    } else {
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.unknown,
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
