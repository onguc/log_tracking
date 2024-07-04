import 'dart:io';

import 'package:isar/isar.dart';
import 'package:log_tracking/src/model/base_entity.dart';
import 'package:log_tracking/src/model/log_info.dart';
import 'package:log_tracking/src/model/singular_entity.dart';
import 'package:path_provider/path_provider.dart';

/// Created by İrfan Öngüç
/// on 18.10.2022

abstract class BaseRepo<T extends BaseEntity> {
  static late final Isar _isar;

  static Future<void> init() async {
    var path = await _createFolderIfNotExists();

    _isar = await Isar.open(
      [
        LogInfoSchema,
        SingularEntitySchema,
      ],
      inspector: true,
      directory: path,
    );
  }

  Isar get isar {
    return _isar;
  }

  IsarCollection<T> get baseCollection => _isar.collection<T>();

  Future<T?> getById(int keyId) {
    return baseCollection.get(keyId);
  }

// int get length => box.length;

  Future<List<T>> getAlls() {
    return baseCollection.where().findAll();
  }

// Iterable<dynamic> get keys => box.keys;
//
  Future<List<T?>> getAllByIds(List<int> ids) {
    return baseCollection.getAll(ids);
  }

  Future<int> save(T t) {
    return _isar.writeTxn(() async {
      int id = await baseCollection.put(t);
      t.id = id;
      return id;
    });
  }

  Future<int> add(T t) {
    return save(t);
  }

  Future<void> update(T t) {
    return save(t);
  }

  Future<List<int>> saveAll(List<T> tList) {
    return _isar.writeTxn(() => baseCollection.putAll(tList));
  }

  Future<bool> deleteById(int id) {
    return _isar.writeTxn(() => baseCollection.delete(id));
  }

  Future<int> deleteAllByIds(List<int> ids) {
    return _isar.writeTxn(() => baseCollection.deleteAll(ids));
  }

  Future<int> clearAll() {
    return _isar.writeTxn(() => baseCollection.where().deleteAll());
  }

  Future<void> close() {
    return _isar.close();
  }

// final cheapest = await isar.products.filter()
//     .sortByPrice()
//     .limit(4)
//     .findAll();

// final cheapestFast = await isar.products.where()
//     .anyPrice()
//     .limit(4)
//     .findAll();

  static Future<String> _createFolderIfNotExists() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = Directory('${directory.path}/logs');

    if (!(await path.exists())) {
      var directory = await path.create();
      return directory.path;
    }
    return directory.path;
  }
}
