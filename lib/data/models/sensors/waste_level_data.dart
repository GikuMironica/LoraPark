class WasteLevelData {
  DateTime _timestamp;
  int _length;

  WasteLevelData({String timestamp, int length}) {
    this._timestamp = DateTime.parse(timestamp);
    this._length = length;
  }

  DateTime get timestamp => _timestamp;

  int get length => _length;

  WasteLevelData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _length = json['length'];
  }
}