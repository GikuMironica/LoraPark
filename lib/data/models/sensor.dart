import 'package:lorapark_app/config/sensor_list.dart' show SensorType;
import 'package:lorapark_app/data/models/coordinates.dart';

class Sensor {
  final SensorType type;
  final String id;
  final SensorLocation location;

  Sensor({this.type, this.id, this.location});

  double get latitude => location.latitude;

  double get longitude => location.longitude;
}