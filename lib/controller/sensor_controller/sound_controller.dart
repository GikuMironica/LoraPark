import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors/sound_sensor_data.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/sound_sensor.dart';

enum PAGESTATE { IDLE, LOADED, ERROR }

class SoundController extends ChangeNotifier {
  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((SoundSensorRepository).toString());

  PAGESTATE pageState = PAGESTATE.IDLE;

  SoundSensorRepository _soundRepo;
  ScrollController _scrollController = ScrollController();
  List<SoundSensorData> _data = [];

  //controller to set the class
  SoundController({SoundSensorRepository repository}) {
    _soundRepo = repository;
  }
  //function to fetch the data from the backend
  Future<void> fetchData() async {
    setData(await _soundRepo.get(id: SensorEndpoints.soundSensor_one));
    _logger.d('Fetching data');
  }

  void setData(List<SoundSensorData> _listData) {
    _data = _listData;
    notifyListeners();
    _logger.d('Data fetched');
  }

  //get the whole data
  List<SoundSensorData> get data => _data;

  //get fast noises
  double get fastNoise => _data.first.firstdbafast;

  //get continuous noises ===> traffic noises
  double get continuousNoise => _data.first.firstdbaslow;

  //get sound pressure
  double get soundPressure => _data.first.firstleqa;

  ScrollController get scrollController => _scrollController;
}
