extension StringUtil on String? {
  bool get isEmpty => (this == null || this!.trim() == "");

  bool get isNotEmpty {
    return !isEmpty;
  }
}
