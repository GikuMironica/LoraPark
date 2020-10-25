import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/weather_station.dart';
import 'package:lorapark_app/data/models/sensors/weather_station_data.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/screens/widgets/charts/temperature_day_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:intl/intl.dart';

class WeatherStationController extends ChangeNotifier {
  WeatherStationRepository _repository;
  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((WeatherStationRepository).toString());
  ScrollController _scrollController = ScrollController();
  List<WeatherStationData> _data;

  WeatherStationController({WeatherStationRepository repository}) {
    _repository = repository;
    this.Init();
  }

  void Init() {
    getWeatherStationDataByTime(7);
  }

  Future<void> getActualWeatherStationData() async {
    _data = await _repository.get(id: Sensors.weatherStation_one);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getWeatherStationDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data for period of :' +
        startDate.toString() +
        " - " +
        endDate.toString());
    _data = await _repository.getByTime(
      id: Sensors.weatherStation_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<TemperatureDayData> getWeeklyReport() {
    if (_data == null) {
      return null;
    }
    List<TemperatureDayData> report = [];
    var day = DateFormat('E').format(data.first.timeStamp);
    List<double> dayTemp = [];
    List<double> nightTemp = [];
    _data.forEach((element) {
      if (DateFormat('E').format(element.timeStamp) != day) {
        report.add(TemperatureDayData(
            day,
            double.parse(
                (nightTemp.reduce((value, element) => value + element) /
                        nightTemp.length)
                    .toStringAsFixed(1)),
            double.parse((dayTemp.reduce((value, element) => value + element) /
                    dayTemp.length)
                .toStringAsFixed(1))));
        dayTemp = [];
        nightTemp = [];
        day = DateFormat('E').format(element.timeStamp);
      }
      if (element.timeStamp.hour > 18 || element.timeStamp.hour < 6) {
        nightTemp.add(element.temperature);
      } else if (element.timeStamp.hour < 18 || element.timeStamp.hour > 6) {
        dayTemp.add(element.temperature);
      }
    });
    return report;
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
