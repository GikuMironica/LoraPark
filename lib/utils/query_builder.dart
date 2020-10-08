String queryBuilder(List<String> sensorIds) {
  String query = '?';
  for (String id in sensorIds) {
    query = id == sensorIds.last ? '$query=$id' : '${query}id=$id&';
  }
  return query;
}

String timeQueryBuilder(DateTime start, DateTime end) {
  return "&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}";
}
