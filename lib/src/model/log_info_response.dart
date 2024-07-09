import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'log_info_response.g.dart';

@JsonSerializable()
class LogInfoResponse extends BaseResponse {
  LogInfoResponse();

  factory LogInfoResponse.fromJson(Map<String, dynamic> json) => _$LogInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogInfoResponseToJson(this);
}
