import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> wasteLevelList = [
  Sensor(
    type: SensorType.WASTE_LEVEL,
    id: Sensors.wasteLevel,
    location: SensorLocations.muellSensor,
  ),
];