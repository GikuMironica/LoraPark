import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> weatherStationList = [
  Sensor(
    type: SensorType.weather_station,
    id: SensorEndpoints.weatherStation_one,
    name: 'Weather Station',
    number: '01',
    image: AssetImage('assets/images/weather_station.jpg'),
    location: SensorLocations.weatherStation,
  ),
];
