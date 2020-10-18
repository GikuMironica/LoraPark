import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/waste_level_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/waste_level.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class WasteLevelController extends ChangeNotifier {
  final WasteLevelRepository _repository;
  final ScrollController _scrollController = ScrollController();
  List<WasteLevelData> _data;

  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((WasteLevelRepository).toString());

  WasteLevelController({@required WasteLevelRepository repository})
      : _repository = repository;

  Future<void> getActualWasteLevelData() async {
    _logger.d('Fetching data');
    _data = await _repository.get(id: Sensors.wasteLevel);
    notifyListeners();
  }

  Future<void> getWasteLevelDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));

    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.wasteLevel,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  ScrollController get scrollController => _scrollController;

  List<WasteLevelData> get data => _data;

  int get length => _data.first.length;

  int get filling => _data.first.filling;

  double get fillRatio => _data.first.filling / 100;

  bool isFull() {
    return _data.first.length <= 30;
  }

  double getPercentFull() {
    return (data.where((e) => e.filling / 100 > 0.8).toList().length /
            data.length *
            100)
        .round()
        .toDouble();
  }

  double getPercentEmpty() {
    return (data.where((e) => e.filling / 100 <= 0.8).toList().length /
            data.length *
            100)
        .round()
        .toDouble();
  }
}
