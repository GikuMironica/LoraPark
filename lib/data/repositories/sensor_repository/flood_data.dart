import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show FloodData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class FloodDataRepository extends BaseSensorRepository{
  @override
  String get endpoint => Endpoints.FLOOD_DATA;

  List<FloodData> convert(Iterable it) {
    return it.map((e) => FloodData.fromJson(e)).toList();
  }

  @override
  Future<List<FloodData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<FloodData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
 