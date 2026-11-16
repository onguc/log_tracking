import 'package:json_annotation/json_annotation.dart';

/// Kind of a log entry
enum EnumLogType {
  /// Debug message; never sent to the server
  @JsonValue('DEBUG')
  debug,

  /// Informational message
  @JsonValue('INFO')
  info,

  /// Warning message
  @JsonValue('WARNING')
  warning,

  /// Error message
  @JsonValue('ERROR')
  error,
}
