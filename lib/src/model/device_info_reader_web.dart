import 'package:web/web.dart' as web;

import '../enum/enum_device_type.dart';
import 'device_info.dart';

/// Reads the browser details on web without touching `dart:io`.
///
/// This keeps the package usable from WebAssembly builds, where
/// `device_info_plus` (which imports `dart:io`) cannot be loaded.
Future<DeviceInfo> readDeviceInfo(String appVersion) async {
  final userAgent = web.window.navigator.userAgent;
  return DeviceInfo(
    deviceType: EnumDeviceType.web,
    versionSdkInt: web.window.navigator.appVersion,
    brand: _browserName(userAgent),
    appVersion: appVersion,
    isPhysicalDevice: true,
  );
}

/// Best effort browser name taken from the user agent string
String _browserName(String userAgent) {
  final ua = userAgent.toLowerCase();
  if (ua.contains('edg/')) return 'edge';
  if (ua.contains('opr/') || ua.contains('opera')) return 'opera';
  if (ua.contains('firefox')) return 'firefox';
  if (ua.contains('chrome') || ua.contains('crios')) return 'chrome';
  if (ua.contains('safari')) return 'safari';
  return 'unknown';
}
