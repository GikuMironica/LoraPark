import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> raisedGardenList = [
  Sensor(
    type: SensorType.RAISED_GARDEN,
    id: Sensors.raisedGarden,
    location: SensorLocations.autarkesHochbeet,
  ),
];