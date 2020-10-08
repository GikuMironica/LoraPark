class StructureDamageData {
  DateTime _timestamp;
  double _distance;

  StructureDamageData({String timestamp, double distance}){
    _timestamp = DateTime.parse(timestamp);
    _distance = distance;
  }

  factory StructureDamageData.fromJson(Map<String, dynamic> json){
    return StructureDamageData(
      timestamp: json['timestamp'],
      distance: json['distance']
    );
  }

  double get distance => _distance;

  DateTime get timestamp => _timestamp;
}