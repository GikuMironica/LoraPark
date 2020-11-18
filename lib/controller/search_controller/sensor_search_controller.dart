import 'package:flutter/foundation.dart';
import 'package:lorapark_app/controller/search_controller/search_controller.dart';
import 'package:lorapark_app/data/models/sensor.dart';

class SensorSearchController extends SearchController {
  List<Sensor> _allSensors;
  List<Sensor> _filteredSensors;

  SensorSearchController({@required List<Sensor> sensors}) : super() {
    Future.delayed(Duration(milliseconds: 500), () {
      _allSensors =
          sensors.where((sensor) => sensor.number.isNotEmpty).toList();
      _filteredSensors = _allSensors;
      notifyListeners();
    });
  }

  List<Sensor> get filteredSensors => _filteredSensors;

  @override
  void filter() {
    var originalQuery = textEditingController.text.trim();

    if (originalQuery.isEmpty) {
      _filteredSensors = _allSensors;
      notifyListeners();
      return;
    }

    var query = originalQuery
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9 ]'), ' ')
        .trim();
    var keywords = query.split(RegExp(' +'));

    _filteredSensors = _filterSensors(keywords);
    notifyListeners();
  }

  List<Sensor> _filterSensors(List<String> keywords) {
    return _allSensors
        .where((sensor) => keywords.length == 1 && keywords.first.isEmpty
            ? false
            : keywords.every((keyword) =>
                sensor.name.toLowerCase().contains(keyword) ||
                sensor.description.toLowerCase().contains(keyword) ||
                sensor.number.contains(keyword)))
        .toList();
  }
}
