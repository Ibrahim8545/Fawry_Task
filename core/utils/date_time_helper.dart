DateTime createFutureDate(int daysFromNow) {
  return DateTime.now().add(Duration(days: daysFromNow));
}

/// Helper function to create past date
DateTime createPastDate(int daysAgo) {
  return DateTime.now().subtract(Duration(days: daysAgo));
}
