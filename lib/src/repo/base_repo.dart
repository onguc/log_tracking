import 'package:hive/hive.dart';

import '../model/base_hive_model.dart';

/// Created by İrfan Öngüç
/// on 16.03.2022

abstract class BaseRepo<T extends BaseHiveModel> {
  Box<T> get box {
    if (_box == null) _box = Hive.box<T>(keyTableName);
    return _box!;
  }

  Box<T>? _box;

  String get keyTableName;

  T? getByKeyId(String keyId) {
    return box.get(keyId);
  }

  int get length => box.length;

  List<T> getAlls() {
    return box.values.toList();
  }

  Iterable<dynamic> get keys => box.keys;

  List<T> getAllByKeys(Iterable<String> keys) {
    List<T> list = [];
    for (String key in keys) {
      var t = getByKeyId(key);
      if (t != null) list.add(t);
    }
    return list;
  }

  Future<void> save(T t) {
    return box.put(t.keyId, t);
  }

  Future<void> saveAll(List<T> tList) {
    var maps = {for (var t in tList) t.keyId: t};
    return box.putAll(maps);
  }

  Future<void> deleteByKeyId(String keyId) {
    var x = box.delete(keyId);
    return x;
  }

  Future<void> deleteAllByKeys(Iterable<dynamic> keys) {
    return box.deleteAll(keys);
  }

  Future<int> clearAll() {
    return box.clear();
    // getAlls().forEach((element) {
    //   deleteByKeyId(element.keyId!);
    // });
  }

  void open() {
    if (!box.isOpen) _box = Hive.box<T>(keyTableName);
  }

  Future<void> close() {
    return box.close();
  }
}
