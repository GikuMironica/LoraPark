
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/ground_humidity.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class GrouundHumidityController extends ChangeNotifier {
  GroundHumidityRepository _repository;
  final Logger _logger = GetIt.I.get<LoggingService>().getLogger((GrouundHumidityController).toString());
  ScrollController  _scrollController = ScrollController();
  List<GroundHumidityData> _data;


  GrouundHumidityController({GroundHumidityRepository repository}) : _repository = repository;

  Future<void> getActualGroundHumidityData() async {
    _data = await _repository.get(id: Sensors.groundHumidity_one);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getGroundHumidityDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.groundHumidity_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<GroundHumidityData> get data => _data;



  double get maxTemperature =>
      _data.map<double>((e) => e.temperature).reduce(max);

  double get minTemperature =>
      _data.map<double>((e) => e.temperature).reduce(min);

  double get temperature => _data.first.temperature;

  double get vwc => _data.first.vwc;

  DateTime get timestamp => _data.first.timestamp;

  ScrollController get scrollController => _scrollController;
}