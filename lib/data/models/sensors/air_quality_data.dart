class AirQualityData {
  DateTime _timestamp;
  double _no2Concentration;
  double _noConcentration;
  double _coConcentration;

  AirQualityData({
    String timestamp,
    double no2Concentration,
    double noConcentration,
    double coConcentration
  }) {
    _timestamp = DateTime.parse(timestamp);
    _no2Concentration = no2Concentration;
    _noConcentration = noConcentration;
    _coConcentration = coConcentration;
  }

  factory AirQualityData.fromJson(Map<String, dynamic> json){
    return AirQualityData(
      timestamp: json['timestamp'],
      no2Concentration: json['no2concentration'],
      noConcentration: json['noconcentration'],
      coConcentration: json['coconcentration']
    );
  }

  double get coConcentration => _coConcentration;

  double get noConcentration => _noConcentration;

  double get no2Concentration => _no2Concentration;

  DateTime get timestamp => _timestamp;
}