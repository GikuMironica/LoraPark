class RatData {
  final String decoy;
  final String poison;
  final List<RatVisitData> visits;

  RatData({this.decoy, this.poison, this.visits});

  DateTime get decoyDay => DateTime.parse(decoy);
  DateTime get poisonDay => DateTime.parse(poison);
}


class RatVisitData {
  final String x;
  final int y;

  RatVisitData({this.x, this.y});

  factory RatVisitData.fromJson(Map<String, dynamic> json) =>
      RatVisitData(x: json['x'], y: json['y']);

  DateTime get date => DateTime.parse(x);

  int get visitorCount => y;
}

