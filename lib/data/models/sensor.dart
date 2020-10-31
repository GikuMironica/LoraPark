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

  Sensor(
      {this.type, this.id, this.name, this.number, this.image, this.location});

  double get latitude => location.latitude;

  double get longitude => location.longitude;
}
