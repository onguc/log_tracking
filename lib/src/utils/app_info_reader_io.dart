import 'package:package_info_plus/package_info_plus.dart';

import 'app_info.dart';

/// Reads the application metadata on native platforms.
Future<AppInfo> readAppInfo() async {
  final info = await PackageInfo.fromPlatform();
  return AppInfo(
    appName: info.appName,
    packageName: info.packageName,
    version: info.version,
    buildNumber: info.buildNumber,
  );
}
