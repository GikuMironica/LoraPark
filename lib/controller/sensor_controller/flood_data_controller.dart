import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/flood_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/flood_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class FloodDataController extends ChangeNotifier {
  final FloodDataRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<FloodData> _data;

  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((FloodDataRepository).toString());

  FloodDataController({@required FloodDataRepository repository})
      : _repository = repository {
    init();
  }

  void init() {
    getFloodDataByTime(7);
  }

  Future<void> getActualFloodData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: SensorEndpoints.floodData);
    notifyListeners();
  }

  Future<void> getFloodDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: SensorEndpoints.floodData,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<FloodData> get data => _data;

  ScrollController get scrollController => _scrollController;

  double get currentDistance => _data.first.distance / 10.0;
}
