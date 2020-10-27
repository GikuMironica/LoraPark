import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/person_count.dart';
import 'package:lorapark_app/screens/widgets/charts/temperature_day_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:intl/intl.dart';

class PersonCountController extends ChangeNotifier {
  PersonCountRepository _repository;
  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((PersonCountController).toString());
  ScrollController _scrollController = ScrollController();
  List<PersonCountData> _data;

  PersonCountController ({PersonCountRepository repository}){
    _repository = repository;
    this.Init();
  }

  void Init(){
    fetchData();
  }

  Future<void> fetchData() async {
    _data = await _repository.get(id: Sensors.personCount_one);
    _logger.d('Fetching data');
    notifyListeners();
  }

  Future<void> getPersonDataByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _data = await _repository.getByTime(
      id: Sensors.personCount_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  List<PersonCountData> get data => _data;

  int get paxCount => _data.first.paxCount;

  DateTime get timestamp => _data.first.timestamp;

  ScrollController get scrollController => _scrollController;
}
