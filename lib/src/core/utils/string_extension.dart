extension StringExtension on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  double toDouble() {
    return double.tryParse(this) ?? 0;
  }

  bool toBool() {
    return toLowerCase() == 'true';
  }
}

extension StringNullableExtension on String? {
  int toInt() {
    if (this == null) return 0;
    return int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    if (this == null) return 0;
    return double.tryParse(this!) ?? 0;
  }

  bool toBool() {
    if (this == null) return false;
    return this!.toLowerCase() == 'true';
  }
}
