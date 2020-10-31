import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> parkingSensorList = [
  Sensor(
    id: Sensors.parking_one,
    type: SensorType.PARKING,
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: Sensors.parking_two,
    type: SensorType.PARKING,
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: Sensors.parking_three,
    type: SensorType.PARKING,
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: Sensors.parking_four,
    type: SensorType.PARKING,
    location: SensorLocations.parkingSensor,
  ),
];