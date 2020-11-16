import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/screens/screens.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/sensor_page/sound_sensor_page.dart';

var sensorList = GetIt.I.get<Sensors>().list;

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
      Init(),
);

var settingsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        SettingsPage());

var ARHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        AugmentedRealityPage());

var airQualityHandler = Handler(handlerFunc: (context, params) {
  var airQualitySensor = sensorList
      .firstWhere((sensor) => sensor.id == SensorEndpoints.airQuality_one);
  return SelectedSensor(sensor: airQualitySensor, child: AirQualityPage());
});

var doorHandler = Handler(
  handlerFunc: (context, params) {
    var doorSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.door_one);
    return SelectedSensor(sensor: doorSensor, child: DoorPage());
  },
);

var energyHandler = Handler(
  handlerFunc: (context, params) {
    var energySensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.energyData_two);
    return SelectedSensor(sensor: energySensor, child: EnergyDataPage());
  },
);

var floodHandler = Handler(
  handlerFunc: (context, params) {
    var floodSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.floodData);
    return SelectedSensor(sensor: floodSensor, child: FloodDataPage());
  },
);

var groundHumidityHandler = Handler(
  handlerFunc: (context, params) {
    var groundHumiditySensor = sensorList.firstWhere(
        (sensor) => sensor.id == SensorEndpoints.groundHumidity_one);
    return SelectedSensor(
        sensor: groundHumiditySensor, child: GroundHumidityPage());
  },
);

var parkingHandler = Handler(
  handlerFunc: (context, params) {
    var parkingSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.parking_one);
    return SelectedSensor(sensor: parkingSensor, child: ParkingPage());
  },
);

var personCountHandler = Handler(
  handlerFunc: (context, params) {
    var personCountSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.personCount_one);
    return SelectedSensor(sensor: personCountSensor, child: PersonCountPage());
  },
);

var raisedGardenHandler = Handler(
  handlerFunc: (context, params) {
    var raisedGardenSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.raisedGarden);
    return SelectedSensor(
        sensor: raisedGardenSensor, child: RaisedGardenPage());
  },
);

var structureDamageHandler = Handler(
  handlerFunc: (context, params) {
    var structureDamageSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.structureDamage);
    return SelectedSensor(
        sensor: structureDamageSensor, child: StructureDamagePage());
  },
);

var wasteLevelHandler = Handler(
  handlerFunc: (context, params) {
    var wasteLevelSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.wasteLevel);
    return SelectedSensor(sensor: wasteLevelSensor, child: WasteLevelPage());
  },
);

var weatherStationHandler = Handler(
  handlerFunc: (context, params) {
    var weatherStationSensor = sensorList.firstWhere(
        (sensor) => sensor.id == SensorEndpoints.weatherStation_one);
    return SelectedSensor(
        sensor: weatherStationSensor, child: WeatherStationPage());
  },
);

var soundSensorHandler = Handler(
  handlerFunc: (context, params) {
    var soundSensor = sensorList
        .firstWhere((sensor) => sensor.id == SensorEndpoints.soundSensor_one);
    return SelectedSensor(sensor: soundSensor, child: SoundSensorPage());
  },
);

var ratSensorHandler = Handler(
  handlerFunc: (context, params) {
    var ratSensor = sensorList.firstWhere((sensor) => sensor.number == '13');
    return SelectedSensor(sensor: ratSensor, child: RatPage());
  },
);
