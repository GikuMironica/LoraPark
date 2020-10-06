import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/main.dart';
import 'package:lorapark_app/screens/settings/settings.dart';

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => MyHomePage()
);

var settingsHandler = Handler(
  handlerFunc:  (BuildContext context, Map<String, List<String>> params) => SettingsPage()
);