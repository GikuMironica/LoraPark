import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show CO2Data;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class CO2Repository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.CO2;

  List<CO2Data> convert(Iterable it) {
    return it.map((e) => CO2Data.fromJson(e)).toList();
  }

  @override
  Future<List<CO2Data>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<CO2Data>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
