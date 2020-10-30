import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> personCountList = [
  Sensor(
    type: SensorType.PERSON_COUNT,
    id: Sensors.personCount_one,
    location: SensorLocations.besucherStrom,
  )
];