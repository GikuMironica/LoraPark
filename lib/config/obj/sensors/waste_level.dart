import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> wasteLevelList = [
  Sensor(
    type: SensorType.waste_level,
    id: SensorEndpoints.wasteLevel,
    name: 'Waste Level',
    number: '04',
    image: AssetImage('assets/images/container.jpg'),
    location: SensorLocations.wasteLevel,
  ),
];
