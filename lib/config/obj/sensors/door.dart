import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> doorSensorList = [
  Sensor(
    id: SensorEndpoints.door_one,
    type: SensorType.door,
    name: 'Door',
    number: '11',
    image: AssetImage('assets/images/door.jpg'),
    location: SensorLocations.doorSensor,
  )
];
