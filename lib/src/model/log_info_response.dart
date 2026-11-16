import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'log_info_response.g.dart';

/// Response returned after logs are uploaded.
@JsonSerializable()
class LogInfoResponse extends BaseResponse {
  /// Creates an empty response
  LogInfoResponse();

  /// Creates a response from JSON
  factory LogInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$LogInfoResponseFromJson(json);

  /// Converts this response to JSON
  Map<String, dynamic> toJson() => _$LogInfoResponseToJson(this);
}
