import 'package:intl/intl.dart';
import 'package:log_tracking/src/utils/custom_date_format.dart';

/// Created by İrfan Öngüç
/// on 11 September 2020

class DateTimeUtil {
  static String getDateTimeForLog(DateTime dateTime) {
    String _timeZoneFormat = "yyyy-MM-ddTHH:mm:ssTZD";
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static dateStringForFileName(DateTime dateTime) {
    String _timeZoneFormat = "yyyy_MM_dd__HHmmss";
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }
}
