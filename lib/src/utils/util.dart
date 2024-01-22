import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:log_tracking/src/model/device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Created by İrfan Öngüç
/// on 24 May 2021

class Util {
  static String? _version = "";
  static String deviceId = "";
  final bool isCanPrintLog = !kIsWeb || kDebugMode;

  static Future<String?>? get version async {
    if ((_version == null || _version!.isEmpty) && !kIsWeb) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        _version = packageInfo.version;
      } catch (e) {
        return "";
      }
    }
    return _version;
  }
}
