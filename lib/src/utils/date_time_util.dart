import 'package:intl/intl.dart';
import 'package:log_tracking/src/utils/custom_date_format.dart';

/// Created by İrfan Öngüç
/// on 11 September 2020

class DateTimeUtil {
  static formatByTimeZone(DateTime dateTime) {
    String _timeZoneFormat = "yyyy-MM-ddTHH:mm:ss.sssTZD";
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static dateStringWithSeconds(DateTime dateTime) {
    String _timeZoneFormat = getFormatForWithSeconds();
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static String getDateTimeForLog(DateTime dateTime) {
    String _timeZoneFormat = getDateTimeForLogFormat();
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static dateStringForFileName(DateTime dateTime) {
    String _timeZoneFormat = getFormatForFileName();
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  static String translateToLocaleDateAsString(String dateString) {
    try {
      if (dateString == null || dateString == "") return "";
      var dateFormat = CustomDateFormat(getFormatForField());
      var dateLocal = dateFormat.parseForLocal(dateString);
      var dateTimeLocalString = dateFormat.format(dateLocal!);
      return dateTimeLocalString;
    } catch (e) {
      return "";
    }
  }

  static String getCurrentDateTimeForLocalAsString() {
    DateTime time = DateTime.now();
    return getDateTimeStringForField(time);
  }

  static String getDateTimeStringForField(DateTime dateTime) {
    if (dateTime == null) return "";
    var format = getFormatForField();
    return DateFormat(format).format(dateTime);
  }

  static String getDateStringForField(DateTime dateTime) {
    if (dateTime == null) return "";
    var format = getDateFormat();
    return DateFormat(format).format(dateTime);
  }

  static String getDateTimeStringByTimeZoneZero(DateTime dateTime) {
    var format = getDateTimeFormatForField3();
    var x = dateTime.timeZoneOffset;
    var n = dateTime.subtract(x);
    String dateString = DateFormat(format).format(n);
    dateString = "$dateString+00:00";
    return dateString;
  }

  static String getTimeString(DateTime dateTime) {
    var format = _getTimeFormat();
    return DateFormat(format).format(dateTime);
  }

  // static String getDateTimeFormatForField() => "yyyy-MM-ddTHH:mm:ss";

  static String getFormatForField() => "yyyy-MM-dd HH:mm";

  static String getFormatForWithSeconds() => "yyyy-MM-dd HH:mm:ss";

  static String getFormatForFileName() => "yyyy_MM_dd__HHmmss";

  static String getDateTimeFormat() => "yyyy-MM-ddTHH:mm:ss";

  static String getDateTimeFormatByTimeZone2() => "yyyy-MM-dd kk:mm";

  static String getDateTimeFormatForField3() => "yyyy-MM-ddTHH:mm:ss.sss";

  static String getDateTimeForLogFormat() => "yyyy-MM-ddTHH:mm:ssTZD";

  static String getDateFormat() => "yyyy-MM-dd";

  static String _getTimeFormat() => "kk:mm:ss";
// String getDateTimeFormat() => "yyyy-MM-dd'T'HH:mm:ssXXX";

}
