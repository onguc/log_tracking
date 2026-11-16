import 'package:json_annotation/json_annotation.dart';

/// Upload state of a stored log
enum EnumStatus {
  /// Not sent to the server yet
  @JsonValue("UNSENT")
  unsent,

  /// Already sent to the server
  @JsonValue("SENT")
  sent,

  /// Currently being sent
  @JsonValue("SENDING")
  sending,
}
