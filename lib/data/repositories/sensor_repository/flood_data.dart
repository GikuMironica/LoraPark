import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show FloodData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class FloodDataRepository {
  Future<List<FloodData>> getFloodData({String id});

  Future<List<FloodData>> getFloodDataByTime(
      {String id, DateTime start, DateTime end});
}

class FloodDataRepositoryImpl implements FloodDataRepository {
  @override
  Future<List<FloodData>> getFloodData({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.FLOOD_DATA}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => FloodData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<FloodData>> getFloodDataByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.FLOOD_DATA}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => FloodData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
