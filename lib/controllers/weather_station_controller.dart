import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:lorapark_app/data/repositories/sensor_repository/weather_station.dart';
import 'package:lorapark_app/data/models/sensors/weather_station_data.dart';
import 'package:lorapark_app/config/sensor_list.dart';

class WeatherStationController extends ChangeNotifier {
  WeatherStationRepository _repository = WeatherStationRepository();
  List<WeatherStationData> _data;

  Future<void> getActualWeatherStationData() async {
    _data = await _repository.get(id: Sensors.weatherStation_one);
    notifyListeners();
  }

  Future<void> getWeatherStationDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _data = await _repository.getByTime(
      id: Sensors.weatherStation_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<WeatherStationData> get data => _data;

  double get maxTemperature =>
      _data.map<double>((e) => e.temperature).reduce(max);

  double get minTemperature =>
      _data.map<double>((e) => e.temperature).reduce(min);

  int get maxHumidity => _data.map<int>((e) => e.outsideHumidity).reduce(max);

  int get minHumidity => _data.map<int>((e) => e.outsideHumidity).reduce(min);

  DateTime get maxDate => _data.first.date;

  DateTime get minDate => _data.last.date;

  double get rainrate => _data.first.rainRate;

  double get temperature => _data.first.temperature;
}
