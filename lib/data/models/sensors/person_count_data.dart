class PersonCountData {
  DateTime _timestamp;
  int _paxCount;

  PersonCountData({String timestamp, int paxCount}) {
    this._timestamp = DateTime.parse(timestamp);
    this._paxCount = paxCount;
  }

  DateTime get timestamp => _timestamp;

  int get paxCount => _paxCount;

  PersonCountData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _paxCount = json['paxcount'];
  }
}