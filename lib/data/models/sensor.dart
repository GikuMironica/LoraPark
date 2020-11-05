import 'package:flutter/material.dart';
import 'package:lorapark_app/config/sensor_list.dart' show SensorType;
import 'package:lorapark_app/data/models/coordinates.dart';

class Sensor {
  final SensorType type;
  final String id;
  final String name;
  final String number;
  final AssetImage image;
  final SensorLocation location;
  final int rotation;
  final String address;

  Sensor(
      {this.type, this.id, this.name, this.number, this.image, this.location, this.rotation, this.address});
  
  factory Sensor.fromJSON(Map<String, dynamic> json) => Sensor(
    type: SensorType.values[int.parse(json['type'])],
    id: json.containsKey('id') ? json['id'] : '',
    name: json['name'],
    number: json['number'].toString(),
    location: SensorLocation.fromJSON(json['location']),
    rotation: json.containsKey('rotation') ? json['rotation'] : null,
    address: json['address']
  );

  double get latitude => location.latitude;

  double get longitude => location.longitude;
}
