import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show GroundHumidityData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class GroundHumidityRepository extends BaseSensorRepository{
  @override
  String get endpoint => Endpoints.GROUND_HUMIDITY;

  List<GroundHumidityData> convert(Iterable it) {
    return it.map((e) => GroundHumidityData.fromJson(e)).toList();
  }

  @override
  Future<List<GroundHumidityData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<GroundHumidityData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }

}
