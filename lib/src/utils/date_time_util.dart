import 'package:log_tracking/src/utils/custom_date_format.dart';

class DateTimeUtil {
  static String getDateTimeForLog(DateTime dateTime) {
    var customFormat = CustomDateFormat("yyyy-MM-ddTHH:mm:ss.SSS");
    String dateString = customFormat.format(dateTime);
    return dateString;
  }
}
