import 'package:json_annotation/json_annotation.dart';

/// Base class for entities that carry a locale id.
abstract class BaseEntity {
  /// Identifier, serialized as `localeId`
  @JsonKey(name: "localeId")
  int? id;

  /// Creates an entity
  BaseEntity({this.id});
}
