import 'package:json_annotation/json_annotation.dart';

enum EnumLogType {
  // @JsonValue('ALL')
  // ALL,
  // @JsonValue('TRACE')
  // TRACE,
  @JsonValue('DEBUG')
  debug,
  @JsonValue('INFO')
  info,
  @JsonValue('WARNING')
  warning,
  @JsonValue('ERROR')
  error,
  // @JsonValue('SEVERE')
  // SEVERE,
  // @JsonValue('FATAL')
  // FATAL,
}
