import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/services/setup.dart';
import 'package:lorapark_app/lorapark_app.dart';
import 'package:lorapark_app/utils/catcher_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  servicesSetup(isProductionEnv: true);
  // TODO: replace runApp with Catcher if you want to report error logs outside.
  // Catcher(LoRaParkApp(), debugConfig: debugOptions);
  runApp(LoRaParkApp());
}