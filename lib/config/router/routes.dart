import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/config/router/handlers.dart';
import 'package:lorapark_app/config/sensor_list.dart';

class Routes {
  static String root = '/';
  static String settings = '/settings';
  static String sensorPage = '/sensor/';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler =
        Handler(handlerFunc: (_, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
    router.define(sensorPage + Sensors.airQuality_one,
        handler: airQualityHandler);
    router.define(sensorPage + Sensors.door_one, handler: doorHandler);
    router.define(sensorPage + Sensors.energyData_two, handler: energyHandler);
    router.define(sensorPage + Sensors.floodData, handler: floodHandler);
    router.define(sensorPage + Sensors.groundHumidity_one,
        handler: groundHumidityHandler);
    router.define(sensorPage + Sensors.parking_one, handler: parkingHandler);
    router.define(sensorPage + Sensors.personCount_one,
        handler: personCountHandler);
    router.define(sensorPage + Sensors.raisedGarden,
        handler: raisedGardenHandler);
    router.define(sensorPage + Sensors.structureDamage,
        handler: structureDamageHandler);
    router.define(sensorPage + Sensors.wasteLevel, handler: wasteLevelHandler);
    router.define(sensorPage + Sensors.weatherStation_one,
        handler: weatherStationHandler);
  }
}
