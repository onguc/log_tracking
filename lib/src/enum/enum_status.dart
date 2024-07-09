import 'package:json_annotation/json_annotation.dart';

enum EnumStatus {
  @JsonValue("UNSENT")
  unsent,
  @JsonValue("SENT")
  sent,
  @JsonValue("SENDING")
  sending,
}
