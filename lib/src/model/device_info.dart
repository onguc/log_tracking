import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../enum/enum_device_type.dart';

/// Information about the device and the app that produced a log.
class DeviceInfo {
  /// Operating system family of the device
  EnumDeviceType? deviceType;

  /// OS version or SDK level
  String? versionSdkInt;

  /// Device model
  String? model;

  /// Device brand
  String? brand;

  /// Identifier of the device
  String? deviceId;

  /// Version of the host application
  String? appVersion;

  /// Whether the app runs on a physical device
  bool isPhysicalDevice;

  /// Name of the host application
  String? appName;

  /// Creates a device description
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

  /// The current device description; defaults to an empty one before [init]
  static DeviceInfo get instance {
    _instance ??= DeviceInfo(isPhysicalDevice: false);
    return _instance!;
  }

  // factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  /// Reads the device details of the current platform.
  static Future<void> init(String appVersion) async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (kIsWeb) {
      var data =
          await deviceInfoPlugin.webBrowserInfo; // deviceId: 0696220404946b51
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.web,
        brand: data.browserName.name,
        appVersion: appVersion,
        isPhysicalDevice: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      var data = await deviceInfoPlugin
          .iosInfo; // deviceId: 48FFBBAC-B260-47C2-9B5F-BDB2EEF1D1A8
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.ios,
        versionSdkInt: data.systemVersion,
        model: data.model,
        brand: data.model.toLowerCase().contains("ipad") ? "ipad" : "iphone",
        deviceId: data.identifierForVendor,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      var data =
          await deviceInfoPlugin.androidInfo; // deviceId: 0696220404946b51
      final String androidId = await FlutterUdid.udid;
      _instance = DeviceInfo(
        deviceType: EnumDeviceType.android,
        versionSdkInt: "${data.version.sdkInt}",
        model: data.model,
        brand: data.brand,
        deviceId: androidId,
        appVersion: appVersion,
        isPhysicalDevice: data.isPhysicalDevice,
      );
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
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
