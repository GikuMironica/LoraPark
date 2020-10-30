import 'package:lorapark_app/data/models/coordinates.dart' show SensorLocation;

class SensorLocations {
  static SensorLocation poleCoordinates = SensorLocation(48.396426, 9.990453);

  static SensorLocation wetterStation =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static SensorLocation besucherStrom =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static SensorLocation gateWay =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);
  static SensorLocation feinStaub =
      SensorLocation(poleCoordinates.latitude, poleCoordinates.longitude);

  static SensorLocation autarkesHochbeet = SensorLocation(48.396472, 9.990470);
  static SensorLocation oeffnungsSensor = SensorLocation(48.396607, 9.990208);
  static SensorLocation schaedlingsBekaempfung =
      SensorLocation(48.396425, 9.990208);

  static SensorLocation wasserTemperatur = SensorLocation(48.396482, 9.990855);
  static SensorLocation muellSensor = SensorLocation(48.396395, 9.991161);

  static SensorLocation bodenFeuchte = SensorLocation(48.396770, 9.990960);
  static SensorLocation smartBank = SensorLocation(48.396869, 9.990957);

  static SensorLocation luftQualitaet = SensorLocation(48.397206, 9.991628);
  static SensorLocation geraeuschSensor =
      SensorLocation(luftQualitaet.latitude, luftQualitaet.longitude);

  static SensorLocation parkingSensor = SensorLocation(48.397354, 9.993039);
  static SensorLocation feedbackButton =
      SensorLocation(parkingSensor.latitude, parkingSensor.longitude);

  static SensorLocation donaubad = SensorLocation(48.386126, 9.986219);
  static SensorLocation hochwasser = SensorLocation(48.396016, 9.995969);
  static SensorLocation strukturSchaeden = SensorLocation(48.398630, 9.992465);

  static SensorLocation display = SensorLocation(48.396736, 9.991055);
}
