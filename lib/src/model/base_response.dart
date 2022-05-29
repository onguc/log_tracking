abstract class BaseResponse {
  bool? result;
  int? resultCode;
  String? resultMessage;

  BaseResponse({
    this.result,
    this.resultCode,
    this.resultMessage,
  });
}
