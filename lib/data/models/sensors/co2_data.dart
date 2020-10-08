class CO2Data {
  DateTime _timestamp;
  int _co2;

  CO2Data({String timestamp, int co2}) {
    _co2 = co2;
    _timestamp = DateTime.parse(timestamp);
  }

  factory CO2Data.fromJson(Map<String, dynamic> json){
    return CO2Data(timestamp: json['timestamp'], co2: json['co2']);
  }

  DateTime get timestamp => _timestamp;
  int get co2 => _co2;

}