import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'log_info_response.g.dart';

/// Created by İrfan Öngüç
/// on 22.04.2022

@JsonSerializable()
class LogInfoResponse extends BaseResponse {
  LogInfoResponse();

  factory LogInfoResponse.fromJson(Map<String, dynamic> json) => _$LogInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LogInfoResponseToJson(this);
}
