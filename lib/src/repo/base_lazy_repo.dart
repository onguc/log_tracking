import 'package:hive/hive.dart';
import '../model/base_hive_model.dart';

/// Created by İrfan Öngüç
/// on 16.03.2022

abstract class BaseLazyRepo<T extends BaseHiveModel> {
  LazyBox<T>? _lazyBox;

  LazyBox<T> get lazyBox {
    if (_lazyBox == null) _lazyBox = Hive.lazyBox<T>(keyTableName);
    return _lazyBox!;
  }

  // BaseLazyRepo() {
  //   lazyBox = Hive.lazyBox<T>(keyTableName);
  // }

  String get keyTableName;

  Future<T?> getByKeyId(String keyId) {
    return lazyBox.get(keyId);
  }

  int get length => lazyBox.length;

  // List<T> getAlls() {
  //   return box.values.toList();
  // }

  Iterable<dynamic> get keys => lazyBox.keys;

  Future<void> save(T t) {
    return lazyBox.put(t.keyId, t);
  }

  Future<void> saveAll(List<T> tList) {
    var maps = {for (var t in tList) t.keyId: t};
    return lazyBox.putAll(maps);
  }

  Future<void> deleteByKeyId(String keyId) {
    return lazyBox.delete(keyId);
  }

  Future<void> deleteAllByKeys(Iterable<dynamic> keys) {
    return lazyBox.deleteAll(keys);
  }

  Future<int> clearAll() {
    return lazyBox.clear();
  }

  void open() {
    if (!lazyBox.isOpen) _lazyBox = Hive.lazyBox<T>(keyTableName);
  }

  Future<void> close() {
    return lazyBox.close();
  }
}
