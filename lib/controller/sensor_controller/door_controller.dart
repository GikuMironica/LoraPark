import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/door_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/door.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:lorapark_app/utils/date_operations.dart'
    show getDistinctDatesAsString;

class DoorController extends ChangeNotifier {
  DoorRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<DoorData> _data;

  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((DoorRepository).toString());

  DoorController({@required DoorRepository repository}) {
    _repository = repository;
    init();
  }

  void init() async {
    await getDoorDataByTime(7);
  }

  Future<void> getActualDoorData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: SensorEndpoints.door_one);
    notifyListeners();
  }

  Future<void> getDoorDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: SensorEndpoints.door_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<DoorData> get data => _data;

  ScrollController get scrollController => _scrollController;

  int getTotalDailyNumberOfOpenings(DateTime date) {
    return _data
        .where((e) =>
            e.timestamp.year == date.year &&
            e.timestamp.month == date.month &&
            e.timestamp.day == date.day &&
            e.extDigital == 1)
        .length;
  }

  int getMaxTotalDailyNumberOfOpenings(List<DateTime> dates) {
    return dates
        .map<int>((date) => getTotalDailyNumberOfOpenings(date))
        .reduce(max);
  }

  String getLastOpeningTime({String timeFormat = 'HH:mm'}) {
    var date = _data.firstWhere((e) => e.extDigital == 1).timestamp;
    var formatter = DateFormat(timeFormat);
    return formatter.format(date);
  }

  List<String> getDistinctDates({String dateFormat = 'yyyy-MM-dd'}) {
    return getDistinctDatesAsString(
      _data.reversed.map((e) => e.timestamp),
      dateFormat: dateFormat,
    );
  }
}
