import 'package:package_info/package_info.dart';

/// Created by İrfan Öngüç
/// on 24 May 2021

class Util {
  static String? _version;
  static String deviceId = "";

  static Future<String?>? get version async {
    if (_version == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _version = packageInfo.version;
    }
    return _version;
  }
}
