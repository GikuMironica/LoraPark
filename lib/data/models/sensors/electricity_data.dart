class ElectricityData {
  DateTime _timestamp;
  double _value;

  ElectricityData({String timestamp, double value}) {
    _timestamp = DateTime.parse(timestamp);
    _value = value;
  }

  DateTime get timestamp => _timestamp;

  double get value => _value;


  ElectricityData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _value = json['value'];
  }
}