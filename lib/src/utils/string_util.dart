/// Created by İrfan Öngüç
/// on 19 September 2020

class StringUtil {
  static bool isEmptyString(String? string) => string == null || string.trim() == "";

  static bool isNotEmptyString(String? string) => !isEmptyString(string);
}
