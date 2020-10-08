library sensors;

enum SensorType {
  WEATHER_STATION,
  PERSON_COUNT,
  DOOR,
  FEEDBACK_BUTTON,
  ELECTRICITY,
  ENERGY,
  FLOOD_DATA,
  GROUND_HUMIDITY,
  RAISED_GARDEN,
  SOUND_SENSOR,
  WASTE_LEVEL,
  AIR_QUALITY,
  CO2,
  STRUCTURE_DAMAGE,
  PARKING
}

class Sensors {
  // Weather Station Data

  /// Weather Station ID: davis-013d4d
  static const String weatherStation_one = "davis-013d4d";

  // Person Count

  /// Person Count Sensor ID: ttgo-paxcounter01
  static const String personCount_one = "ttgo-paxcounter01";

  // Door

  /// Door Sensor ID: elsysems-a81758fffe04887a
  static const String door_one = "elsysems-a81758fffe04887a";

  // Feedback Button

  /// Feedback Button ID: sa000805-70b3d53260008600
  static const String feedbackButton_one = "sa000805-70b3d53260008600";

  // Electricity

  /// Electricity Sensor ID: dev500004a30b001e2c5d
  static const String electricity_one = "dev500004a30b001e2c5d";

  /// Electricity Sensor ID: dev500004a30b00205757
  static const String electricity_two = "dev500004a30b00205757";

  // Waste Level ---------------------------------------------------------------

  /// Waste Level Sensor ID: 71191
  static const String wasteLevel = "71191";

  // Sound Sensor --------------------------------------------------------------

  /// Sound Sensor ID: iotsoundsensor-deadbeef13374326
  static const String soundSensor_one = "iotsoundsensor-deadbeef13374326";

  // Flood Data ----------------------------------------------------------------

  /// Flood Data Sensor ID: ultraSonic1
  static const String floodData = "ultrasonic1";

  // Raised Garden -------------------------------------------------------------

  /// Raised Garden Sensor ID: node1
  static const String raisedGarden = "node1";

  // Structure Damage ----------------------------------------------------------

  /// Structure Damage Sensor ID: sensor000
  static const String structureDamage = "sensor000";

  // Ground Humidity -----------------------------------------------------------

  /// Ground Humidity Sensor ID: soil_283d7a28b8ee0567
  static const String groundHumidity_one = "soil_283d7a28b8ee0567";

  // Air Quality ---------------------------------------------------------------

  /// Air Quality Sensor ID: dl-ac-001-70b3d57ba0000fc9
  static const String airQuality_one = "dl-ac-001-70b3d57ba0000fc9";

  // Parking -------------------------------------------------------------------

  /// Parking Sensor ID: pbg-r27-19282d
  static const String parking_one = "pbg-r27-19282d";

  /// Parking Sensor ID: pbg-r28-19282a
  static const String parking_two = "pbg-r28-19282a";

  /// Parking Sensor ID: pbg-r29-192829
  static const String parking_three = "pbg-r29-192829";

  /// Parking Sensor ID: pbg-r30-192825
  static const String parking_four = "pbg-r30-192825";

  // Energy Data ---------------------------------------------------------------

  /// Energy Sensor ID: 70113173
  static const String energyData_one = "70113173";


  /// Energy Sensor ID: "000003"
  static const String energyData_two = "000003";

  // CO2 Data ------------------------------------------------------------------

  /// CO2 Sensor ID: elsysco2-045184
  static const String co2Data_one = "elsysco2-045184";

  /// CO2 Sensor ID: elsysco2-048e67
  static const String c02Data_two = "elsysco2-048e67";
}