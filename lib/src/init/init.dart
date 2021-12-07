import 'package:log_tracking/src/utils/util.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Created by İrfan Öngüç
/// on 26 May 2021

class InitClass {
  void init() {
    initPackageInfo();
  }

  initPackageInfo() {
    PackageInfo.fromPlatform().then((info) {
      // Util.version = info.version;
    });
  }
}
