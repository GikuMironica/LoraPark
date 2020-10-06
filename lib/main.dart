import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lorapark_app/services/setup.dart';
import 'package:lorapark_app/lorapark_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  servicesSetup();
  runApp(LoRaParkApp());
}