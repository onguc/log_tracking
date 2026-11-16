import 'package:json_annotation/json_annotation.dart';

/// Severity of an error log
enum EnumLogLevel {
  /// Critical error
  @JsonValue('HIGH')
  high,

  /// Regular error
  @JsonValue('MEDIUM')
  medium,

  /// Minor error
  @JsonValue('LOW')
  low,
}
