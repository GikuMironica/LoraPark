import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> displayList = [
  Sensor(
    type: SensorType.display,
    id: 'display-01',
    location: SensorLocations.display,
  )
];