class WasteLevelData {
  DateTime _timestamp;
  int _length;
  int _filling;

  WasteLevelData({
    String timestamp,
    int length,
    int filling,
  }) {
    this._timestamp = DateTime.parse(timestamp);
    this._length = length;
    this._filling = filling;
  }

  DateTime get timestamp => _timestamp;

  int get length => _length;

  int get filling => _filling;

  WasteLevelData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _length = json['length'];
    _filling = json['filling'];
  }
}
