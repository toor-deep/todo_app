
DateTime parseDueDateTime(String date, String time) {
  if (date.contains('T')) {
    final dt = DateTime.parse(date);
    if (dt.isBefore(DateTime.now())) {
      throw ArgumentError('Scheduled date must be in the future.');
    }
    return dt;
  }

  final datePart = DateTime.parse(date);

  int hour = 0;
  int minute = 0;

  final timeMatch = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)?', caseSensitive: false).firstMatch(time);
  if (timeMatch != null) {
    hour = int.parse(timeMatch.group(1)!);
    minute = int.parse(timeMatch.group(2)!);

    final ampm = timeMatch.group(3);
    if (ampm != null) {
      if (ampm.toUpperCase() == 'PM' && hour != 12) hour += 12;
      if (ampm.toUpperCase() == 'AM' && hour == 12) hour = 0;
    }
  }

  final scheduledDateTime = DateTime(datePart.year, datePart.month, datePart.day, hour, minute);

  if (scheduledDateTime.isBefore(DateTime.now())) {
    throw ArgumentError('Scheduled date must be in the future.');
  }

  return scheduledDateTime;
}
