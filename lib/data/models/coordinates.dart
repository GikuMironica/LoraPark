class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({this.latitude, this.longitude});
}

class SensorLocation extends Coordinates {
  SensorLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);
}

class UserLocation extends Coordinates {
  UserLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);
}