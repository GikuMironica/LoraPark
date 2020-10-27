import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/energy_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/energy.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:lorapark_app/utils/date_operations.dart'
    show getDistinctDatesAsString, getWeekday;

enum _TemperatureType { FLOW, RETURN }

class EnergyDataController extends ChangeNotifier {
  final EnergyDataRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<EnergyData> _data;

  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((EnergyDataRepository).toString());

  EnergyDataController({@required EnergyDataRepository repository})
      : _repository = repository {
    init();
  }

  void init() {
    getEnergyDataByTime(6);
  }

  Future<void> getActualEnergyData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: Sensors.energyData_two);
    notifyListeners();
  }

  Future<void> getEnergyDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.energyData_two,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<EnergyData> get data => _data;

  ScrollController get scrollController => _scrollController;

  double get currentFlowTemperature => _data.first.flowTemperature;

  double get currentReturnTemperature => _data.first.returnTemperature;

  List<Map<DateTime, dynamic>> getWeeklyFlowTemperature(int desiredSize) {
    return _getWeeklyTemperature(desiredSize, _TemperatureType.FLOW);
  }

  List<Map<DateTime, dynamic>> getWeeklyReturnTemperature(int desiredSize) {
    return _getWeeklyTemperature(desiredSize, _TemperatureType.RETURN);
  }

  double getAverageFlowTemperature() {
    return _getAverageTemperature(_TemperatureType.FLOW);
  }

  double getAverageReturnTemperature() {
    return _getAverageTemperature(_TemperatureType.RETURN);
  }

  List<String> getDistinctWeekdays({bool showToday = false}) {
    return getDistinctDatesAsString(_data.reversed.map((e) => e.timestamp))
        .map((e) => getWeekday(e, showToday: showToday))
        .toList();
  }

  List<Map<DateTime, dynamic>> _getWeeklyTemperature(
      int desiredSize, _TemperatureType type) {
    var weeklyTemperature = <Map<DateTime, dynamic>>[];
    var interval = (_data.length / desiredSize + 1).floor();
    var currentIndex = 0;

    while (weeklyTemperature.length != desiredSize) {
      var currentData = _data[currentIndex];
      weeklyTemperature.add({
        currentData.timestamp: type == _TemperatureType.FLOW
            ? currentData.flowTemperature
            : currentData.returnTemperature
      });
      currentIndex += interval;
    }

    return weeklyTemperature.reversed.toList();
  }

  double _getAverageTemperature(_TemperatureType type) {
    var temperatures = _data.map((e) => type == _TemperatureType.FLOW
        ? e.flowTemperature
        : e.returnTemperature);
    return temperatures.reduce((value, element) => value + element) /
        temperatures.length;
  }
}
