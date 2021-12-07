import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Created by İrfan Öngüç
/// on 24 May 2021

class Util {
  static String? _version = "";
  static String deviceId = "";
  static final bool isCanPrintLog = _isPlatformNotWeb || kDebugMode;

  static bool get _isPlatformNotWeb {
    try {
      bool isNotWeb = (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isWindows ||
          Platform.isMacOS ||
          Platform.isLinux ||
          Platform.isFuchsia);
      return isNotWeb;
    } catch (e) {
      return false;
    }
  }

  static Future<String?>? get version async {
    if ((_version == null || _version!.isEmpty) && _isPlatformNotWeb) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _version = packageInfo.version;
    }
    return _version;
  }
}
