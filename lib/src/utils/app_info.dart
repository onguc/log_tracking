import 'app_info_reader.dart';

/// Metadata of the host application.
///
/// The platform specific reader is chosen at compile time, so web and wasm
/// builds do not import `dart:io` through `package_info_plus`.
class AppInfo {
  /// Display name of the application
  final String appName;

  /// Bundle identifier or package name
  final String packageName;

  /// Version from `pubspec.yaml`
  final String version;

  /// Build number from `pubspec.yaml`
  final String buildNumber;

  /// Creates an application description
  const AppInfo({
    this.appName = '',
    this.packageName = '',
    this.version = '',
    this.buildNumber = '',
  });

  /// Reads the metadata of the running application; never throws.
  static Future<AppInfo> read() async {
    try {
      return await readAppInfo();
    } catch (_) {
      return const AppInfo();
    }
  }
}
