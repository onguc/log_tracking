import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Utility class
class Util {
  static String? _version = "";

  /// Get app version
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
