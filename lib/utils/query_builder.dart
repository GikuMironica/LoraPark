String queryBuilder(List<String> sensorIds) {
  var query = '?';
  for (var id in sensorIds) {
    query = id == sensorIds.last ? '$query=$id' : '${query}id=$id&';
  }
  return query;
}

String timeQueryBuilder(DateTime start, DateTime end) {
  var startString = start.toUtc().toIso8601String();
  var endString = end.toUtc().toIso8601String();
  return '&start=$startString&end=$endString';
}
