import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> smartBankList = [
  Sensor(
    type: SensorType.SMART_BANK,
    id: 'smartbank_01',
    location: SensorLocations.smartBank,
  ),
];