class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({this.latitude, this.longitude});
}

class SensorLocation extends Coordinates {
  SensorLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);

  factory SensorLocation.fromJSON(Map<String, dynamic> json){
    return SensorLocation(double.parse(json['latitude'].toString()), double.parse(json['longitude'].toString()));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is SensorLocation && runtimeType == other.runtimeType && longitude == other.longitude && latitude == other.latitude);
  }
  @override
  int get hashCode => longitude.hashCode^latitude.hashCode;

  Map<String, dynamic> toJSON()=>{
    'longitude': longitude,
    'latitude': latitude,

  };
}

class UserLocation extends Coordinates {
  UserLocation([double latitude, double longitude])
      : super(latitude: latitude, longitude: longitude);
}