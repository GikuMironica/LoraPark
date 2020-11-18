import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show ElectricityData;
import 'package:flutter/material.dart' show required;

import 'base_sensor_repository.dart';

abstract class ElectricityRepository extends BaseSensorRepository{

}

class ElectricityRepositoryImpl extends ElectricityRepository{
  @override
  String get endpoint => Endpoints.ELECTRICITY;

  List<ElectricityData> convert(Iterable it) {
    return it.map((e) => ElectricityData.fromJson(e)).toList();
  }

  @override
  Future<List<ElectricityData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<ElectricityData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
