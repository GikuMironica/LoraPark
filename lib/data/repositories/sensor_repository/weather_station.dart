import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show WeatherStationData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class WeatherStationRepository extends BaseSensorRepository{
  @override
  String get endpoint => Endpoints.WEATHER_STATION;

  List<WeatherStationData> convert(Iterable it) {
    return it.map((e) => WeatherStationData.fromJson(e)).toList();
  }

  @override
  Future<List<WeatherStationData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<WeatherStationData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
