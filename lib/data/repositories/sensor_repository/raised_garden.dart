import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show RaisedGardenData;
import 'base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class RaisedGardenRepository extends BaseSensorRepository {

  @override
  String get endpoint => Endpoints.RAISED_GARDEN;

  List<RaisedGardenData> convert(Iterable it) {
    return it.map((e) => RaisedGardenData.fromJson(e)).toList();
  }

  @override
  Future<List<RaisedGardenData>> getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }

  @override
  Future<List<RaisedGardenData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }
}