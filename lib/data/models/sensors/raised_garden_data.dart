class RaisedGardenData{
  DateTime _timestamp;
  int _tensioPressure;
  int _watertankEmpty;

  RaisedGardenData({String timestamp, int tensioPressure, int watertankEmpty}){
    _timestamp = DateTime.parse(timestamp);
    _tensioPressure = tensioPressure;
    _watertankEmpty = watertankEmpty;
  }

  factory RaisedGardenData.fromJson(Map<String, dynamic> json){
    return RaisedGardenData(
      timestamp: json['timestamp'],
      tensioPressure: json['tensio_pressure'],
      watertankEmpty: json['watertank_empty']
    );
  }

  bool get watertankEmpty => _watertankEmpty == 1;

  int get humidity => _tensioPressure;

  DateTime get timestamp => _timestamp;
}