import 'package:flutter/material.dart';
import 'package:lorapark_app/data/models/sensor.dart';

class SelectedSensor extends InheritedWidget {
  final Sensor sensor;

  SelectedSensor({this.sensor, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static SelectedSensor of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SelectedSensor>();
  }
}
