import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/screens.dart';

var rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => Init(),
);

var settingsHandler = Handler(
  handlerFunc:  (BuildContext context, Map<String, List<String>> params) => SettingsPage()
);