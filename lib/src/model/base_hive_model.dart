import 'package:hive/hive.dart';

/// Created by İrfan Öngüç
/// on 16.03.2022

abstract class BaseHiveModel extends HiveObject {
  String? _keyId;

  String? get keyId {
    if (_keyId == null) _keyId = key;
    return _keyId;
  }

  set keyId(String? value) {
    _keyId = value;
  }
}
