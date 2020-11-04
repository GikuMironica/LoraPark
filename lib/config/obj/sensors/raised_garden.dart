import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> raisedGardenList = [
  Sensor(
    type: SensorType.RAISED_GARDEN,
    id: Sensors.raisedGarden,
    name: 'Raised Garden',
    number: '12',
    image: AssetImage('assets/images/raised_garden.jpg'),
    location: SensorLocations.raisedGarden,
  ),
];
