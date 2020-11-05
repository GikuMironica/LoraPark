class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({this.latitude, this.longitude});
}

class SensorLocation extends Coordinates {
  SensorLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);

  factory SensorLocation.fromJSON(Map<String, dynamic> json){
    return SensorLocation(json['latitude'], json['longitude']);
  }
}

class UserLocation extends Coordinates {
  UserLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);
}