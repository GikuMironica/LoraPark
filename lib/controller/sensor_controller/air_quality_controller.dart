import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/air_quality.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/screens/widgets/charts/air_quality_day_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:intl/intl.dart';

class AirQualityController extends ChangeNotifier {
  static final int NO_LIMIT = 127;
  static final int NO2_LIMIT = 101;
  static final int CO_LIMIT = 87;

  AirQualityRepository _repository;
  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((AirQualityRepository).toString());
  ScrollController _scrollController = ScrollController();
  List<AirQualityData> _data;

  AirQualityController({AirQualityRepository repository}) {
    _repository = repository;
  }

  Future<void> getActualAirQualityData() async {
    _data = await _repository.get(id: SensorEndpoints.airQuality_one);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getAirQualityDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: SensorEndpoints.airQuality_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<AirQualityDayData> getWeeklyReport() {
    if (_data == null) {
      return null;
    }
    List<AirQualityDayData> report = [];
    var day = DateFormat('E').format(data.first.timestamp);
    List<double> noconcentration = [];
    List<double> no2concentration = [];
    List<double> coconcentration = [];
    _data.forEach((element) {
      var newDay = DateFormat('E').format(element.timestamp);
      if (newDay != day) {
        report.add(AirQualityDayData(
          day,
          double.parse(
              (noconcentration.reduce((value, element) => value + element) /
                      noconcentration.length)
                  .toStringAsFixed(0)),
          double.parse(
              (no2concentration.reduce((value, element) => value + element) /
                      no2concentration.length)
                  .toStringAsFixed(0)),
          double.parse(
              (coconcentration.reduce((value, element) => value + element) /
                      coconcentration.length)
                  .toStringAsFixed(0)),
        ));
        noconcentration = [];
        no2concentration = [];
        coconcentration = [];
        day = DateFormat('E').format(element.timestamp);
      }
      noconcentration.add(element.noConcentration);
      no2concentration.add(element.no2Concentration);
      coconcentration.add(element.coConcentration);
    });
    return report.reversed.toList();
  }

  String getAirQualityLevel() {
    var sumViolated = 0;
    _data.forEach((d) {
      if (d.noConcentration > NO_LIMIT ||
          d.no2Concentration > NO2_LIMIT ||
          d.coConcentration > CO_LIMIT) {
        sumViolated++;
      }
    });

    var airQualityLevel = '';
    if (sumViolated > 10) {
      airQualityLevel = 'Bad';
    } else if (sumViolated > 5) {
      airQualityLevel = 'Medium';
    } else {
      airQualityLevel = 'Good';
    }

    return airQualityLevel;
  }

  List<AirQualityData> get data => _data;

  double get coConcentration => data.first.coConcentration;

  double get noConcentration => data.first.noConcentration;

  double get no2Concentration => data.first.no2Concentration;

  DateTime get timestamp => data.first.timestamp;

  ScrollController get scrollController => _scrollController;
}
