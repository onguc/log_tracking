import 'package:json_annotation/json_annotation.dart';

/// Which logs are recorded: all logs in debug builds, only production logs otherwise
enum EnumLogTypeGroup {
  /// Logs kept in release builds
  @JsonValue("PRODUCTION")
  production,

  /// Logs kept in debug builds
  @JsonValue("DEBUG")
  debug,
}
