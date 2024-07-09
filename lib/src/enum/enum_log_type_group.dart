import 'package:json_annotation/json_annotation.dart';

enum EnumLogTypeGroup {
  @JsonValue("PRODUCTION")
  production,
  @JsonValue("DEBUG")
  debug,
}
