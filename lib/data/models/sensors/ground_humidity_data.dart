class GroundHumidityData {
  DateTime _timestamp;
  double _temperature;
  double _vwc;

  GroundHumidityData({String timestamp, double temperature, double vwc}){
    _timestamp = DateTime.parse(timestamp);
    _temperature = temperature;
    _vwc = vwc;
  }

  factory GroundHumidityData.fromJson(Map<String, dynamic> json){
    return GroundHumidityData(
      timestamp: json['timestamp'],
      temperature: json['temperature'],
      vwc: json['vwc'],
    );
  }

  double get vwc => _vwc;

  double get temperature => _temperature;

  DateTime get timestamp => _timestamp;
}