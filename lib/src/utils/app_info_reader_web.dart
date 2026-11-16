import 'dart:convert';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'app_info.dart';

/// Reads the application metadata on web from the generated `version.json`.
///
/// `package_info_plus` imports `dart:io`, so it cannot be used from WebAssembly
/// builds; this small reader replaces it there.
Future<AppInfo> readAppInfo() async {
  final href = web.window.location.href;
  final base = href.substring(0, href.lastIndexOf('/') + 1);
  final response = await web.window.fetch('${base}version.json'.toJS).toDart;
  if (response.status != 200) return const AppInfo();
  final body = (await response.text().toDart).toDart;
  final json = jsonDecode(body);
  if (json is! Map) return const AppInfo();
  String read(String key) => json[key]?.toString() ?? '';
  return AppInfo(
    appName: read('app_name'),
    packageName: read('package_name'),
    version: read('version'),
    buildNumber: read('build_number'),
  );
}
