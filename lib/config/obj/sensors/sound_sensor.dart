import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> soundSensorList = [
  Sensor(
    type: SensorType.sound_sensor,
    id: SensorEndpoints.soundSensor_one,
    location: SensorLocations.soundSensor,
    name: 'Sound Sensor',
    number: '03',
  )
];