import 'dart:io';

import 'package:flutter/services.dart';

/// Created by İrfan Öngüç
/// on 26 May 2021

class ExternalStorage {
  static const MethodChannel _channel = const MethodChannel('ext_storage');
  static final String DIRECTORY_DOWNLOADS = "Download";

  static Future<String> getExternalStoragePublicDirectory(String type) async {
    if (!Platform.isAndroid) {
      throw UnsupportedError("Only android supported");
    }
    return await _channel
        .invokeMethod('getExternalStoragePublicDirectory', {"type": type});
  }
}
