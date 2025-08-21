import 'dart:io';

import 'package:log_db/log_db.dart';
import 'package:log_tracking/src/model/base_entity.dart';
import 'package:log_tracking/src/model/log_info.dart';
import 'package:log_tracking/src/model/key_value_entity.dart';
import 'package:path_provider/path_provider.dart';

/// The standard crud transactions of repos take place within this class
abstract class BaseRepo<T extends BaseEntity> {
  static late final LogManager db;

  /// start Db
  static Future<void> init() async {
    // var path = await _createFolderIfNotExists();

    db = await LogManager.open(true);
  }


  /// save entity
  Future<int> save(T t) {
   // db.insertLog(t);
    return Future.value(1);
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
    // return _isar.writeTxn(() => baseCollection.putAll(tList));
    return Future.value(<int>[]);
  }

  /// delete by Id
  Future<bool> deleteById(int id) {
    // return _isar.writeTxn(() => baseCollection.delete(id));
    return Future.value(false);

  }

  /// delete by Id list
  Future<int> deleteAllByIds(List<int> ids) {
    // return _isar.writeTxn(() => baseCollection.deleteAll(ids));
    return Future.value(0);

  }

  /// clear all collection
  Future<int> clearAll() {
    return Future.value(0);

    // return _isar.writeTxn(() => baseCollection.where().deleteAll());
  }

  /// closes the db
  Future<void> close() {
    return Future.value();
    // return _isar.close();
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
