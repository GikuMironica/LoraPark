class EnergyData {
  double _flowTemperature;
  double _returnTemperature;
  DateTime _timestamp;

  EnergyData(
      {double flowTemperature, double returnTemperature, String timestamp}) {
    _flowTemperature = flowTemperature;
    _returnTemperature = returnTemperature;
    _timestamp = DateTime.parse(timestamp);
  }

  double get flowTemperature => _flowTemperature;

  double get returnTemperature => _returnTemperature;

  DateTime get timestamp => _timestamp;

  EnergyData.fromJson(Map<String, dynamic> json) {
    _flowTemperature = json['flowtemperature'];
    _returnTemperature = json['returntemperature'];
    _timestamp = DateTime.parse(json['timestamp']);
  }
}
