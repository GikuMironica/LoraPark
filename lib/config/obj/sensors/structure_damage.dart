import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> structureDamageSensorList = [
  Sensor(
    id: SensorEndpoints.structureDamage,
    type: SensorType.structure_damage,
    name: 'Structure Damage',
    number: '14',
    image: AssetImage('assets/images/structuredamage.jpg'),
    location: SensorLocations.structureDamage,
  ),
];
