import 'base_sensor_repository.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show AirQualityData;
import 'package:flutter/material.dart' show required;

abstract class AirQualityRepository extends BaseSensorRepository{

}

class AirQualityRepositoryImpl extends AirQualityRepository {
  @override
  String get endpoint => Endpoints.AIR_QUALITY;

  List<AirQualityData> convert(Iterable it) {
    return it.map((e) => AirQualityData.fromJson(e)).toList();
  }

  @override
  Future<List<AirQualityData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<AirQualityData>> getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    return convert(
        await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
