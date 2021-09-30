import 'package:log_tracking/src/model/log.dart';

logFromMap(Map<String, dynamic> json) {
  LogModel data = LogModel();
  if (json['id'] != null) {
    data.id =
        json['id'] is String ? int.tryParse(json['id']) : json['id'].toInt();
  }
  if (json['className'] != null) {
    data.className = json['className'].toString();
  }
  if (json['methodName'] != null) {
    data.methodName = json['methodName'].toString();
  }
  if (json['text'] != null) {
    data.text = json['text'].toString();
  }
  if (json['dateTime'] != null) {
    data.dateTime = json['dateTime'].toString();
  }
  if (json['errorString'] != null) {
    data.errorString = json['errorString'].toString();
  }
  if (json['logTypeString'] != null) {
    data.logTypeString = json['logTypeString'].toString();
  }
  if (json['stacktraceString'] != null) {
    data.stacktraceString = json['stacktraceString'].toString();
  }
  if (json['version'] != null) {
    data.version = json['version'].toString();
  }
  return data;
}

Map<String, dynamic> logToJson(LogModel entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['className'] = entity.className;
  data['methodName'] = entity.methodName;
  data['text'] = entity.text;
  data['dateTime'] = entity.dateTime;
  data['errorString'] = entity.errorString;
  data['logTypeString'] = entity.logTypeString;
  data['stacktraceString'] = entity.stacktraceString;
  data['version'] = entity.version;
  return data;
}
