import 'package:intl/intl.dart';


class CustomDateFormat extends DateFormat {
  String? newPattern;

  CustomDateFormat([this.newPattern]) : super(newPattern);

  @override
  String format(DateTime date) {
    if (newPattern != null && newPattern!.endsWith("TZD")) {
      return _formatWithTimeZone(date);
    }
    return super.format(date);
  }

  String _formatWithTimeZone(DateTime date) {
    if (newPattern != null) {
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

  @override
  DateTime parse(String inputString, [bool utc = false]) {
    return super.parse(inputString, utc);
  }
}
