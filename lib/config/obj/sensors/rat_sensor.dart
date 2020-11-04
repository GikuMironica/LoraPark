import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

// TODO: specify rat sensor id
List<Sensor> ratSensorList = [
  Sensor(
    type: SensorType.RAT_SENSOR,
    id: 'RatSensor',
    location: SensorLocations.ratSensor,
    number: '03',
    name: 'Rat Sensor'
  )
];