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
    router.define(sensorPage + SensorEndpoints.airQuality_one,
        handler: airQualityHandler);
    router.define(sensorPage + SensorEndpoints.door_one, handler: doorHandler);
    router.define(sensorPage + SensorEndpoints.energyData_two, handler: energyHandler);
    router.define(sensorPage + SensorEndpoints.floodData, handler: floodHandler);
    router.define(sensorPage + SensorEndpoints.groundHumidity_one,
        handler: groundHumidityHandler);
    router.define(sensorPage + SensorEndpoints.parking_one, handler: parkingHandler);
    router.define(sensorPage + SensorEndpoints.personCount_one,
        handler: personCountHandler);
    router.define(sensorPage + SensorEndpoints.raisedGarden,
        handler: raisedGardenHandler);
    router.define(sensorPage + SensorEndpoints.structureDamage,
        handler: structureDamageHandler);
    router.define(sensorPage + SensorEndpoints.wasteLevel, handler: wasteLevelHandler);
    router.define(sensorPage + SensorEndpoints.weatherStation_one,
        handler: weatherStationHandler);
  }
}
