String queryBuilder(List<String> sensorIds){
  String query = '?';
  for(String id in sensorIds){
    query = id == sensorIds.last ? '$query=$id' : '${query}id=$id&';
  }
  return query;
}