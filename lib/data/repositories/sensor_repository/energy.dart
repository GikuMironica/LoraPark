import 'package:flutter/foundation.dart' show required;
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors/energy_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';

abstract class EnergyDataRepository extends BaseSensorRepository {}

class EnergyDataRepositoryImpl extends EnergyDataRepository {
  @override
  String get endpoint => Endpoints.ENERGY_DATA;

  List<EnergyData> convert(Iterable it) {
    return it.map((e) => EnergyData.fromJson(e)).toList();
  }

  @override
  Future<List<EnergyData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<EnergyData>> getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    return convert(
        await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
