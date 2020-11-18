class DoorData {
  DateTime _timestamp;
  int _extDigital;

  DoorData({String timestamp, int extDigital}) {
    this._timestamp = DateTime.parse(timestamp);
    this._extDigital = extDigital;
  }

  DateTime get timestamp => _timestamp;
  int get extDigital => _extDigital;


  DoorData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _extDigital = json['extdigital'];
  }
}