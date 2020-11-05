import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/waste_level_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/waste_level.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class WasteLevelController extends ChangeNotifier {
  static final MAX_LENGTH = 132;
  static final MIN_LENGTH = 30;
  static final FILL_RATIO_THRESHOLD = 75;

  WasteLevelRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<WasteLevelData> _data;

  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((WasteLevelRepository).toString());

  WasteLevelController({@required WasteLevelRepository repository}) {
    _repository = repository;
    init();
  }

  void init() {
    getWasteLevelDataByTime(6);
  }

  Future<void> getActualWasteLevelData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: SensorEndpoints.wasteLevel);
    notifyListeners();
  }

  Future<void> getWasteLevelDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: SensorEndpoints.wasteLevel,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  ScrollController get scrollController => _scrollController;

  List<WasteLevelData> get data => _data;

  int get length => _data.first.length;

  double get currentFillRatio => _getFillRatio(_data.first.length);

  double _getFillRatio(int length) {
    return min((MAX_LENGTH - length).abs(), (MAX_LENGTH - MIN_LENGTH)) /
        (MAX_LENGTH - MIN_LENGTH) *
        100;
  }

  double getPercentFull() {
    return (_data
                .where((e) => _getFillRatio(e.length) > FILL_RATIO_THRESHOLD)
                .length /
            _data.length *
            100)
        .round()
        .toDouble();
  }

  double getPercentEmpty() {
    return (_data
                .where((e) => _getFillRatio(e.length) <= FILL_RATIO_THRESHOLD)
                .length /
            _data.length *
            100)
        .round()
        .toDouble();
  }
}
