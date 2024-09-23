import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class BaseEntity {
  @JsonKey(name: "localeId")
  Id? id;

  BaseEntity({this.id});
}
