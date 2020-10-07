import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show AirQualityData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class AirQualityRepository {
  Future<List<AirQualityData>> getAirQuality({String id});

  Future<List<AirQualityData>> getAirQualityByTime(
      {String id, DateTime start, DateTime end});
}

class AirQualityRepositoryImpl implements AirQualityRepository {
  @override
  Future<List<AirQualityData>> getAirQuality({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.AIR_QUALITY}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => AirQualityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<AirQualityData>> getAirQualityByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.AIR_QUALITY}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => AirQualityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
