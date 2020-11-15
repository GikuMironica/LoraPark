import 'package:fluro/fluro.dart';
import 'package:lorapark_app/config/router/handlers.dart';

class Routes {
  static String root = '/';
  static String settings = '/settings';
  static String sensorPage = '/sensor/';
  static String ARPage = '/ar/';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler =
        Handler(handlerFunc: (_, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
    router.define(ARPage, handler: ARHandler);
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
    router.define(sensorPage + '03', handler: soundSensorHandler);
    router.define(sensorPage + '13', handler: ratSensorHandler);
  }
}
