import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> structureDamageSensorList = [
  Sensor(
    id: Sensors.structureDamage,
    type: SensorType.STRUCTURE_DAMAGE,
    location: SensorLocations.strukturSchaeden,
  ),
];