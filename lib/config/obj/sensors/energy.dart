import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';


// TODO: Locations...
List<Sensor> energyList = [
  Sensor(
    id: Sensors.energyData_one,
    type: SensorType.ENERGY,
  ),
  Sensor(
    id: Sensors.energyData_two,
    type: SensorType.ENERGY,
  )
];