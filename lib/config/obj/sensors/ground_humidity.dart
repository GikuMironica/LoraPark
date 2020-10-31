import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> groundHumidityList = [
  Sensor(
    type: SensorType.GROUND_HUMIDITY,
    id: Sensors.groundHumidity_one,
    location: SensorLocations.bodenFeuchte,
  )
];