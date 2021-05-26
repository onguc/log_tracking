import 'package:intl/intl.dart';
import 'package:log_tracking/src/utils/string_util.dart';

/// Created by İrfan Öngüç
/// on 10 October 2020

class CustomDateFormat extends DateFormat {
  String? newPattern;
  static String _timeZoneFormat = "yyyy-MM-ddTHH:mm:ss.sssTZD";

  CustomDateFormat([this.newPattern]):super(newPattern);


  static String formatByTimeZone(DateTime dateTime) {
    var customFormat = CustomDateFormat(_timeZoneFormat);
    String dateString = customFormat.format(dateTime);
    return dateString;
  }

  @override
  String format(DateTime date) {
    if (date != null) {
      if (newPattern!=null && newPattern!.endsWith("TZD")) {
        return _formatWithTimeZone(date);
      }
      return super.format(date);
    }
    return "";
  }

  String _formatWithTimeZone(DateTime date) {
    if (newPattern != null && date != null) {
      newPattern = newPattern!.trim();
      if (newPattern!.endsWith("TZD") || newPattern!.endsWith("Z")) {
        try {
          String ptrn1 = newPattern!.replaceAll("TZD", "");
          ptrn1 = ptrn1.replaceAll("Z", "");

          DateTime dateTimeLocal = date.toLocal();
          String dateLocalString = DateFormat(ptrn1).format(dateTimeLocal);
          var x = dateTimeLocal.timeZoneOffset;
          String aa = x.toString();
          List<String> kk = aa.split(":");
          var flagAndHours = kk[0];
          var minutes = kk[1];
          String flag = "+";
          var hours;
          if (["+", "-"].contains(flagAndHours[0])) {
            flag = flagAndHours[0];
            hours = flagAndHours.substring(1, flagAndHours.length);
          } else {
            hours = flagAndHours;
          }
          if (hours.length == 1) hours = "0$hours";

          String aaa = "$dateLocalString$flag$hours:$minutes";
          return aaa;
        } catch (e) {
          return "";
        }
      }
    }
    return "";
  }

  String getDateTimeStringNowForLocal() {
    DateTime dateTime = DateTime.now();
    DateTime dateTimeLocal = dateTime.toLocal();
    return dateTimeLocal.toString();
  }

  DateTime? parseForLocal(String dateString) {
    try {
      if (StringUtil.isEmptyString(dateString)) return null;
      DateTime dateTime = DateTime.parse(dateString);
      DateTime dateTimeLocal = dateTime.toLocal();
      return dateTimeLocal;
    } catch (e) {
      return null;
    }
  }

  @override
  DateTime parse(String inputString, [bool utc = false]) {
    // TODO: implement parse
    return super.parse(inputString, utc);
  }

  void test() {
    String d2String = "2020-10-01T13:52:13.372+02:00";
    RegExpMatch? match = _parseFormat.firstMatch(d2String);
    int k = 0;
  }

  static final RegExp _parseFormat =
      RegExp(r'^([+-]?\d{4,6})-?(\d\d)-?(\d\d)' // Day part.
          r'(?:[ T](\d\d)(?::?(\d\d)(?::?(\d\d)(?:[.,](\d+))?)?)?' // Time part.
          r'( ?[zZ]| ?([-+])(\d\d)(?::?(\d\d))?)?)?$'); // Timezone part.
}
