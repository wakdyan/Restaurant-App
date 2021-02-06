class DateHelper {
  static DateTime get scheduledTime {
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, 11);

    if (now.isAfter(scheduledTime)) return scheduledTime.add(Duration(days: 1));

    return scheduledTime;
  }
}
