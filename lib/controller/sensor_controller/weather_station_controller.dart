import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'package:lorapark_app/data/repositories/sensor_repository/weather_station.dart';
import 'package:lorapark_app/data/models/sensors/weather_station_data.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class WeatherStationController extends ChangeNotifier {
  WeatherStationRepository _repository;
  final Logger _logger = GetIt.I.get<LoggingService>().getLogger((WeatherStationRepository).toString());
  ScrollController  _scrollController = ScrollController();
  List<WeatherStationData> _data;


  WeatherStationController({WeatherStationRepository repository}) : _repository = repository;

  Future<void> getActualWeatherStationData() async {
    _data = await _repository.get(id: Sensors.weatherStation_one);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getWeatherStationDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
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

  ScrollController get scrollController => _scrollController;
}
