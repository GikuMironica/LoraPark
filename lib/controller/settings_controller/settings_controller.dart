import 'package:flutter/cupertino.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/sensor_repository.dart';

class SettingsController extends ChangeNotifier {
  final PersonCountRepository _repository;
  List<PersonCountData> _data = [];

  List<PersonCountData> get data => _data;

  SettingsController({PersonCountRepository repository}) : _repository = repository;

  Future<void> fetchData() async {
    _data = await _repository.get(id: SensorEndpoints.personCount_one);
    notifyListeners();
  }
}