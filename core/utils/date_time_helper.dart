DateTime createFutureDate(int daysFromNow) {
  return DateTime.now().add(Duration(days: daysFromNow));
}

DateTime createPastDate(int daysAgo) {
  return DateTime.now().subtract(Duration(days: daysAgo));
}
