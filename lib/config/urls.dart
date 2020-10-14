// DO NOT MODIFY THIS FILE !!

const String BASE_URL = 'https://citysens.exxcellent.de/api/datasets';
const String AUTH_URL =
    'https://citysens.exxcellent.de/management-api/oauth2/token';

class Endpoints {
  static const String CO2 = '/elsysvalues';
  static const String WEATHER_STATION = '/weatherstation';
  static const String PERSON_COUNT = '/besucherstrom';
  static const String DOOR = '/door';
  static const String FEEDBACK_BUTTON = '/action_button';
  static const String ELECTRICITY = '/electricity';
  static const String WASTE_LEVEL = '/swufillvalues';
  static const String SOUND_SENSOR = '/lautstaerke';
  static const String FLOOD_DATA = '/hochwasser';
  static const String RAISED_GARDEN = '/loraparkhochbeet';
  static const String STRUCTURE_DAMAGE = '/rissensor';
  static const String GROUND_HUMIDITY = '/bodenfeuchte';
  static const String AIR_QUALITY = '/airquality';
  static const String PARKING_STATE = '/swuparkingvalues';
  static const String PARKING_EVENTS = '/swuparkingvalues/parkingEvents';
  static const String PARKING_AVERAGE_DURATION =
      '/swuparkingvalues/parkingDurationAverage';
  static const String PARKING_HISTORY =
      '/swuparkingvalues/parkingOccupationAverage';
  static const String ENERGY_DATA = '/swuheatmetervalues';
}
