import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> parkingSensorList = [
  Sensor(
    id: SensorEndpoints.parking_one,
    type: SensorType.parking,
    name: 'Parking',
    number: '05',
    image: AssetImage('assets/images/parking_sensor.png'),
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: SensorEndpoints.parking_two,
    type: SensorType.parking,
    name: 'Parking',
    number: '05',
    image: AssetImage('assets/images/parking_sensor.png'),
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: SensorEndpoints.parking_three,
    type: SensorType.parking,
    name: 'Parking',
    number: '05',
    image: AssetImage('assets/images/parking_sensor.png'),
    location: SensorLocations.parkingSensor,
  ),
  Sensor(
    id: SensorEndpoints.parking_four,
    type: SensorType.parking,
    name: 'Parking',
    number: '05',
    image: AssetImage('assets/images/parking_sensor.png'),
    location: SensorLocations.parkingSensor,
  ),
];
