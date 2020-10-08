import 'package:lorapark_app/config/sensor_list.dart' show SensorType;

class Sensor {
  SensorType _type;
  String _id;
  double _longitude;
  double _latitude;

  Sensor({SensorType sensorType, String id, double longitude, double latitude}){
    _type = sensorType;
    _id = id;
    _latitude = latitude;
    _longitude = longitude;
  }

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get id => _id;

  SensorType get type => _type;
}