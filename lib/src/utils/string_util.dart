/// Utility extension for String
extension StringUtil on String? {
  /// Checks if string is empty or null
  bool get isEmpty => (this == null || this!.trim() == "");

  /// Checks if string is not empty
  bool get isNotEmpty {
    return !isEmpty;
  }
}
