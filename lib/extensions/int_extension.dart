extension IntExtension on int {
  int floorToMultipleOf(int multiple) {
    return ((this / multiple).floor() * multiple);
  }
}
