import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensor.dart';

class Sensors {
  static Sensors _sensors;
  final List<Sensor> _sensorList = <Sensor>[];
  List<Sensor> get list => _sensorList;

  factory Sensors() {
    return _sensors ?? Sensors._();
  }

  Sensors._(){
    parseSensors();
  }

  void parseSensors() async {
    final jsonObj = jsonDecode(await loadJson());
    Map<String, dynamic> sensorList = jsonObj['sensors'];
    for(var type in SensorType.values){
      var sensorTypeList = sensorList[describeEnum(type)];
      for(var sensor in sensorTypeList) {
        _sensorList.add(Sensor.fromJSON(sensor));
      }
    }
  }

  Future<String> loadJson() async {
    return await rootBundle.loadString('assets/json/sensors.json');
  }
}