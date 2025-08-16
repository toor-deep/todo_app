import 'package:intl/intl.dart';

import '../provider/task_provider.dart';

DateTime? getScheduledDateTime(DateTime selectedDate, String confirmedTime, bool use24hFormat) {
  try {
    late int hour;
    late int minute;

    if (use24hFormat) {
      final parts = confirmedTime.split(":");
      hour = int.parse(parts[0]);
      minute = int.parse(parts[1]);
    } else {
      final dateTime = DateFormat.jm().parse(confirmedTime);
      hour = dateTime.hour;
      minute = dateTime.minute;
    }

    final scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );

    // Check if it's in the future
    if (scheduledDateTime.isBefore(DateTime.now())) {
      return null;
    }

    return scheduledDateTime;
  } catch (e) {
    return null;
  }
}

extension EnumToString on SyncAction{
  String toShortString() {
    return toString();
  }
}
