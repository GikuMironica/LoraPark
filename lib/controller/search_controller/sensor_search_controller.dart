import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/search_controller/search_controller.dart';
import 'package:lorapark_app/data/models/sensor.dart';

class SensorSearchController extends SearchController<Sensor> {
  List<Sensor> _filteredSensors = [];

  SensorSearchController({@required List<Sensor> sensors})
      : super(objects: sensors) {
    _filteredSensors = sensors;
  }

  List<Sensor> get filteredSensors => _filteredSensors;

  @override
  void filter() {
    var originalQuery = textEditingController.text.trim();
    var query = originalQuery
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9 ]'), ' ')
        .trim();
    var keywords = query.split(RegExp(' +'));

    if (originalQuery.isEmpty) {
      _filteredSensors = allObjects;
      notifyListeners();
      return;
    }

    _filteredSensors = allObjects
        .where((sensor) => keywords.length == 1 && keywords.first.isEmpty
            ? false
            : keywords.every((keyword) =>
                sensor.name.toLowerCase().contains(keyword) ||
                sensor.number.contains(keyword)))
        .toList();

    notifyListeners();
  }
}
