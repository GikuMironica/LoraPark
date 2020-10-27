
import 'package:flutter/material.dart';

class Sensor {
  final String title;
  final  String description;
  final  String sensorNumber;
  final String address;
  final MaterialPageRoute route;

  Sensor(this.title, this.description,this.sensorNumber, this.address, this.route);

  MaterialPageRoute callpage() {
     return route;
  }
}
