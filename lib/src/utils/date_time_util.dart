import 'package:log_tracking/src/utils/custom_date_format.dart';

/// Created by İrfan Öngüç
/// on 11 September 2020

class DateTimeUtil {
  static String getDateTimeForLog(DateTime dateTime) {
    // String _timeZoneFormat = "yyyy-MM-ddTHH:mm:ss.SSSTZD";
    // var customFormat = getCustomDateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    var customFormat = CustomDateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static DateTime parseDateTime(String dateTimeString) {
    // var customFormat = getCustomDateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    var customFormat = CustomDateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    DateTime parse = customFormat.parse(dateTimeString);
    return parse;
  }
}
