import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show SoundSensorData;
import 'base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class SoundSensorRepository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.SOUND_SENSOR;

  List<SoundSensorData> convert(Iterable it) {
    return it.map((e) => SoundSensorData.fromJson(e)).toList();
  }

  @override
  Future<List<SoundSensorData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<SoundSensorData>> getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    return convert(
        await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
