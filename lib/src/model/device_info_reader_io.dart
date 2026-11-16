import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../enum/enum_device_type.dart';
import 'device_info.dart';

/// Reads the device details on native platforms.
///
/// `device_info_plus` and `flutter_udid` import `dart:io`, so they are only
/// reached from here; the web build uses [device_info_reader_web.dart] instead.
Future<DeviceInfo> readDeviceInfo(String appVersion) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    final data = await deviceInfoPlugin.iosInfo;
    return DeviceInfo(
      deviceType: EnumDeviceType.ios,
      versionSdkInt: data.systemVersion,
      model: data.model,
      brand: data.model.toLowerCase().contains("ipad") ? "ipad" : "iphone",
      deviceId: data.identifierForVendor,
      appVersion: appVersion,
      isPhysicalDevice: data.isPhysicalDevice,
    );
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    final data = await deviceInfoPlugin.androidInfo;
    final String androidId = await FlutterUdid.udid;
    return DeviceInfo(
      deviceType: EnumDeviceType.android,
      versionSdkInt: "${data.version.sdkInt}",
      model: data.model,
      brand: data.brand,
      deviceId: androidId,
      appVersion: appVersion,
      isPhysicalDevice: data.isPhysicalDevice,
    );
  }
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    final data = await deviceInfoPlugin.macOsInfo;
    return DeviceInfo(
      deviceType: EnumDeviceType.macos,
      model: data.model,
      brand: "macos",
      deviceId: data.systemGUID,
      appVersion: appVersion,
      isPhysicalDevice: true,
    );
  }
  if (defaultTargetPlatform == TargetPlatform.linux) {
    final data = await deviceInfoPlugin.linuxInfo;
    return DeviceInfo(
      deviceType: EnumDeviceType.linux,
      versionSdkInt: data.version,
      model: data.prettyName,
      brand: "linux",
      deviceId: data.machineId,
      appVersion: appVersion,
      isPhysicalDevice: true,
    );
  }
  if (defaultTargetPlatform == TargetPlatform.windows) {
    final data = await deviceInfoPlugin.windowsInfo;
    return DeviceInfo(
      deviceType: EnumDeviceType.windows,
      versionSdkInt:
          "${data.majorVersion}.${data.minorVersion}.${data.buildNumber}",
      model: data.productName,
      brand: "windows",
      deviceId: data.deviceId,
      appVersion: appVersion,
      isPhysicalDevice: true,
    );
  }
  return DeviceInfo(
    deviceType: EnumDeviceType.unknown,
    versionSdkInt: "1",
    model: "testModel",
    brand: "testBrand",
    deviceId: "TestDeviceId_123455",
    appVersion: appVersion,
    isPhysicalDevice: false,
  );
}
