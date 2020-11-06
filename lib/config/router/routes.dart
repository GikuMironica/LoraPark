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
    router.define(sensorPage + '02', handler: airQualityHandler);
    router.define(sensorPage + '11', handler: doorHandler);
    router.define(sensorPage + '15', handler: energyHandler);
    router.define(sensorPage + '08', handler: floodHandler);
    router.define(sensorPage + '09', handler: groundHumidityHandler);
    router.define(sensorPage + '05', handler: parkingHandler);
    router.define(sensorPage + '10', handler: personCountHandler);
    router.define(sensorPage + '12', handler: raisedGardenHandler);
    router.define(sensorPage + '14', handler: structureDamageHandler);
    router.define(sensorPage + '04', handler: wasteLevelHandler);
    router.define(sensorPage + '01', handler: weatherStationHandler);
  }
}
