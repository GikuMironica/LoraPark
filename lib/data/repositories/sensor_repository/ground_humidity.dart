import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show GroundHumidityData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class GroundHumidityRepository {
  Future<List<GroundHumidityData>> getGroundHumidity({String id});

  Future<List<GroundHumidityData>> getGroundHumidityByTime(
      {String id, DateTime start, DateTime end});
}

class GroundHumidityRepositoryImpl implements GroundHumidityRepository {
  @override
  Future<List<GroundHumidityData>> getGroundHumidity({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.GROUND_HUMIDITY}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => GroundHumidityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<GroundHumidityData>> getGroundHumidityByTime({String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.GROUND_HUMIDITY}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => GroundHumidityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

}
