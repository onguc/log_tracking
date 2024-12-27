import 'package:json_annotation/json_annotation.dart';

abstract class BaseEntity {
  @JsonKey(name: "localeId")
  int? id;

  BaseEntity({this.id});
}
