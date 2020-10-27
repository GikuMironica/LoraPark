import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> feedbackButtonList = [
  Sensor(
    id: Sensors.feedbackButton_one,
    location: SensorLocations.feedbackButton,
    type: SensorType.FEEDBACK_BUTTON,
  )
];