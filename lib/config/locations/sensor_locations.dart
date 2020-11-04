import 'package:lorapark_app/data/models/coordinates.dart' show SensorLocation;

class SensorLocations {
  static final SensorLocation poleCoordinates = SensorLocation(48.396426, 9.990453);

  static final SensorLocation weatherStation =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static final SensorLocation personCount =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static final SensorLocation gateWay =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static SensorLocation particleSensor =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);

  static SensorLocation raisedGarden = SensorLocation(48.396472, 9.990470);
  static SensorLocation doorSensor = SensorLocation(48.396607, 9.990208);
  static SensorLocation ratSensor =
      SensorLocation(48.396425, 9.990268);

  static SensorLocation waterTemperature = SensorLocation(48.396482, 9.990855);
  static SensorLocation wasteLevel = SensorLocation(48.396395, 9.991161);

  static SensorLocation groundHumidity = SensorLocation(48.396770, 9.990960);
  static SensorLocation smartBank = SensorLocation(48.396869, 9.990957);

  static SensorLocation airQuality = SensorLocation(48.397206, 9.991628);
  static SensorLocation soundSensor =
      SensorLocation(airQuality.latitude, airQuality.longitude);

  static SensorLocation parkingSensor = SensorLocation(48.397354, 9.993039);
  static SensorLocation feedbackButton =
      SensorLocation(parkingSensor.latitude, parkingSensor.longitude);

  static SensorLocation energySensor = SensorLocation(48.386126, 9.986219);
  static SensorLocation floodData = SensorLocation(48.396016, 9.995969);
  static SensorLocation structureDamage = SensorLocation(48.398630, 9.992465);

  static SensorLocation display = SensorLocation(48.396736, 9.991055);
}
