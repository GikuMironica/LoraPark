
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/raised_garden.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

class RaisedGardenController extends ChangeNotifier {
  RaisedGardenRepository _repository;
  final Logger _logger = GetIt.I.get<LoggingService>().getLogger((RaisedGardenController).toString());
  ScrollController  _scrollController = ScrollController();
  List<RaisedGardenData> _data;


  RaisedGardenController({RaisedGardenRepository repository}) : _repository = repository;

  Future<void> getRaisedGardennData() async {
    _data = await _repository.get(id: Sensors.raisedGarden);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getRaisedGardenDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.raisedGarden,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<RaisedGardenData> get data => _data;

  ScrollController get scrollController => _scrollController;

  bool get watertankEmpty => _data.first.watertankEmpty;

  int get humidity => _data.first.humidity;

  DateTime get timestamp => _data.first.timestamp;

}