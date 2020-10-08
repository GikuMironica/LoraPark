import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show PersonCountData;
import 'base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class PersonCountRepository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.PERSON_COUNT;

  List<PersonCountData> convert(Iterable it) {
    return it?.map((e) => PersonCountData.fromJson(e))?.toList();
  }

  @override
  Future<List<PersonCountData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<PersonCountData>> getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    return convert(
        await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
