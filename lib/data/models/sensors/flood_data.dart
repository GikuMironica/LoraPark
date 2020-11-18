class FloodData {
  int _distance;
  DateTime _timestamp;

  FloodData({int distance, String timestamp}) {
    this._distance = distance;
    this._timestamp = DateTime.parse(timestamp);
  }

  int get distance => _distance;

  DateTime get timestamp => _timestamp;

  FloodData.fromJson(Map<String, dynamic> json) {
    _distance = json['distance'];
    _timestamp = DateTime.parse(json['timestamp']);
  }
}