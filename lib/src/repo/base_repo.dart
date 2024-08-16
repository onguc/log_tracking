import 'dart:io';

import 'package:isar/isar.dart';
import 'package:log_tracking/src/model/base_entity.dart';
import 'package:log_tracking/src/model/log_info.dart';
import 'package:log_tracking/src/model/key_value_entity.dart';
import 'package:path_provider/path_provider.dart';

/// The standard crud transactions of repos take place within this class
abstract class BaseRepo<T extends BaseEntity> {
  static late final Isar _isar;

  /// start Db
  static Future<void> init() async {
    var path = await _createFolderIfNotExists();

    _isar = await Isar.open(
      [
        LogInfoSchema,
        KeyValueEntitySchema,
      ],
      name: "log_tracking",
      inspector: true,
      directory: path,
    );
  }

  /// in special cases, it allows repos to reach _isar in the base repo
  Isar get isar {
    return _isar;
  }

  /// get entity collection from generic
  IsarCollection<T> get baseCollection => _isar.collection<T>();

  /// get by Id
  Future<T?> getById(int keyId) {
    return baseCollection.get(keyId);
  }



  /// get All entities
  Future<List<T>> getAlls() {
    return baseCollection.where().findAll();
  }


  /// get All entities by Id List
  Future<List<T?>> getAllByIds(List<int> ids) {
    return baseCollection.getAll(ids);
  }

  /// save entity
  Future<int> save(T t) {
    return _isar.writeTxn(() async {
      int id = await baseCollection.put(t);
      t.id = id;
      return id;
    });
  }

  /// add entity
  Future<int> add(T t) {
    return save(t);
  }

  /// update entity
  Future<void> update(T t) {
    return save(t);
  }

  /// save multiple entity
  Future<List<int>> saveAll(List<T> tList) {
    return _isar.writeTxn(() => baseCollection.putAll(tList));
  }

  /// delete by Id
  Future<bool> deleteById(int id) {
    return _isar.writeTxn(() => baseCollection.delete(id));
  }

  /// delete by Id list
  Future<int> deleteAllByIds(List<int> ids) {
    return _isar.writeTxn(() => baseCollection.deleteAll(ids));
  }

  /// clear all collection
  Future<int> clearAll() {
    return _isar.writeTxn(() => baseCollection.where().deleteAll());
  }

  /// closes the db
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
