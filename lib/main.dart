import 'package:flutter/material.dart';
import 'package:lorapark_app/services/setup.dart';
import 'package:lorapark_app/lorapark_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  servicesSetup();
  runApp(LoRaParkApp());
}