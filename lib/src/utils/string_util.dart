/// Created by İrfan Öngüç
/// on 19 September 2020

class StringUtil {
  static bool isEmpty(String? string) => string == null || string.trim() == "";

  static bool isNotEmpty(String? string) => !isEmpty(string);
}
