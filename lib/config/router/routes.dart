import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lorapark_app/config/router/handlers.dart';

class Routes {
  static String root = '/';
  static String settings = '/settings';

  static void configureRoutes(Router router){
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });

    router.define(root, handler: rootHandler);
    router.define(settings, handler: settingsHandler);
  }
}