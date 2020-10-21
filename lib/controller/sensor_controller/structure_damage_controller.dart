import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/structure_damage_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/structure_damage.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class StructureDamageController extends ChangeNotifier {
  final StructureDamageRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<StructureDamageData> _data;

  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((StructureDamageRepository).toString());

  StructureDamageController({@required StructureDamageRepository repository})
      : _repository = repository;

  Future<void> getActualStructureDamageData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: Sensors.structureDamage);
    notifyListeners();
  }

  Future<void> getStructureDamageDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.structureDamage,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  double getAverageDistancePerDay(DateTime date) {
    var distancesPerDay = _data
        .where((e) =>
            e.timestamp.day == date.day &&
            e.timestamp.month == date.month &&
            e.timestamp.year == date.year)
        .map((e) => e.distance);
    return distancesPerDay.reduce((value, element) => value + element) /
        distancesPerDay.length;
  }

  double getDistanceDifferenceInLastDays(int days) {
    var today = DateTime.now();
    var startDate = today.subtract(Duration(days: days));

    var difference =
        getAverageDistancePerDay(today) - getAverageDistancePerDay(startDate);
    return difference.abs();
  }

  List<StructureDamageData> get data => _data;

  ScrollController get scrollController => _scrollController;

  double get currentDistance => _data.first.distance;
}
