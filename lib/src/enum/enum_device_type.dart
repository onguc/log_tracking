import 'package:json_annotation/json_annotation.dart';

/// Specifies the device type
enum EnumDeviceType {
  @JsonValue('ANDROID')
  android,
  @JsonValue('IOS')
  ios,
  @JsonValue('MACOS')
  macos,
  @JsonValue('LINUX')
  linux,
  @JsonValue('WINDOWS')
  windows,
  @JsonValue('WEB')
  web,
  @JsonValue('UNKNOWN')
  unknown,
}
