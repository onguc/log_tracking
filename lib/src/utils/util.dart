import 'dart:io';

import 'package:package_info/package_info.dart';

/// Created by İrfan Öngüç
/// on 24 May 2021

class Util {
  static String? _version = "";
  static String deviceId = "";
  static final bool isNotWeb = _isPlatformWeb;

  static bool get _isPlatformWeb {
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
    if ((_version == null || _version!.isEmpty) && isNotWeb) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _version = packageInfo.version;
    }
    return _version;
  }
}
