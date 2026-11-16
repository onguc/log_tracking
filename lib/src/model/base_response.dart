/// Base class for responses returned by the server.
abstract class BaseResponse {
  /// Whether the request succeeded
  bool? result;

  /// Status code returned by the server
  int? resultCode;

  /// Human readable status message
  String? resultMessage;

  /// Creates a response
  BaseResponse({
    this.result,
    this.resultCode,
    this.resultMessage,
  });
}
