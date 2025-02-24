class DateFormatter {
  // Formats the date in MM-dd-yy HH:mm:ss format with each field as 2-digit numbers.
  static String format(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final month = twoDigits(dateTime.month);
    final day = twoDigits(dateTime.day);
    final year = twoDigits(dateTime.year % 100);
    final hour = twoDigits(dateTime.hour);
    final minute = twoDigits(dateTime.minute);
    final second = twoDigits(dateTime.second);
    return '$month-$day-$year $hour:$minute:$second';
  }
}
