import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show WasteLevelData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class WasteLevelRepository {
  Future<List<WasteLevelData>> getWasteLevel({String id});

  Future<List<WasteLevelData>> getWasteLevelByTime(
      {String id, DateTime start, DateTime end});
}

class WasteLevelRepositoryImpl implements WasteLevelRepository {
  @override
  Future<List<WasteLevelData>> getWasteLevel({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.WASTE_LEVEL}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => WasteLevelData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<WasteLevelData>> getWasteLevelByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.WASTE_LEVEL}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => WasteLevelData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
