import 'package:json_annotation/json_annotation.dart';

enum EnumLogLevel {
  @JsonValue('HIGH')
  high,
  @JsonValue('MEDIUM')
  medium,
  @JsonValue('LOW')
  low,
}
