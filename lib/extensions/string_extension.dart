extension StringExtension on String {
  String get capitalized {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}
