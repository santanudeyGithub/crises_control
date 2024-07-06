extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String initals() {
    return isNotEmpty
        ? trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
        : '';
  }
}
