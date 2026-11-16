import 'package:json_annotation/json_annotation.dart';

/// Specifies the device type
enum EnumDeviceType {
  /// Android device
  @JsonValue('ANDROID')
  android,

  /// iOS device
  @JsonValue('IOS')
  ios,

  /// macOS device
  @JsonValue('MACOS')
  macos,

  /// Linux device
  @JsonValue('LINUX')
  linux,

  /// Windows device
  @JsonValue('WINDOWS')
  windows,

  /// Web browser
  @JsonValue('WEB')
  web,

  /// Unknown or unsupported device
  @JsonValue('UNKNOWN')
  unknown,
}
