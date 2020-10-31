import 'package:flutter/material.dart';
import 'package:lorapark_app/config/locations/sensor_locations.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

List<Sensor> groundHumidityList = [
  Sensor(
    type: SensorType.GROUND_HUMIDITY,
    id: Sensors.groundHumidity_one,
    name: 'Ground Humidity',
    number: '09',
    image: AssetImage('assets/images/ground_humidity.jpg'),
    location: SensorLocations.bodenFeuchte,
  )
];
