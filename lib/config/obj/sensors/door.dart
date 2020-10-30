import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> doorSensorList = [
  Sensor(
    id: Sensors.door_one,
    type: SensorType.DOOR,
    location: SensorLocations.oeffnungsSensor,
  )
];