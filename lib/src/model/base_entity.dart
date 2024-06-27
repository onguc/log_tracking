import 'package:isar/isar.dart';

/// Created by İrfan Öngüç
/// on 11.11.2022

abstract class BaseEntity {
  Id id;

  BaseEntity({this.id = Isar.autoIncrement});
}
