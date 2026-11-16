import '../enum/enum_device_type.dart';
import 'device_info_reader.dart';

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

  /// Reads the device details of the current platform.
  ///
  /// The platform specific reader is chosen at compile time, so web builds do
  /// not pull in `dart:io` through the device plugins.
  static Future<void> init(String appVersion) async {
    _instance = await readDeviceInfo(appVersion);
  }
}
