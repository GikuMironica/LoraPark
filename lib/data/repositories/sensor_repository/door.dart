import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show DoorData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class DoorRepository extends BaseSensorRepository{
  @override
  String get endpoint => Endpoints.DOOR;

  List<DoorData> convert(Iterable it) {
    return it.map((e) => DoorData.fromJson(e)).toList();
  }

  @override
  Future<List<DoorData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<DoorData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}