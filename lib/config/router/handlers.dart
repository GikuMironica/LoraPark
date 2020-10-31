import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/screens.dart';

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
      Init(),
);

var settingsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
        SettingsPage());

var airQualityHandler = Handler(
  handlerFunc: (context, params) => AirQualityPage(),
);

var doorHandler = Handler(
  handlerFunc: (context, params) => DoorPage(),
);

var energyHandler = Handler(
  handlerFunc: (context, params) => EnergyDataPage(),
);

var floodHandler = Handler(
  handlerFunc: (context, params) => FloodDataPage(),
);

var groundHumidityHandler = Handler(
  handlerFunc: (context, params) => GroundHumidityPage(),
);

var parkingHandler = Handler(
  handlerFunc: (context, params) => ParkingPage(),
);

var personCountHandler = Handler(
  handlerFunc: (context, params) => PersonCountPage(),
);

var raisedGardenHandler = Handler(
  handlerFunc: (context, params) => RaisedGardenPage(),
);

var structureDamageHandler = Handler(
  handlerFunc: (context, params) => StructureDamagePage(),
);

var wasteLevelHandler = Handler(
  handlerFunc: (context, params) => WasteLevelPage(),
);

var weatherStationHandler = Handler(
  handlerFunc: (context, params) => WeatherStationPage(),
);
