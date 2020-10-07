import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show DoorData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class DoorRepository {
  Future<List<DoorData>> getDoor({String id});

  Future<List<DoorData>> getDoorByTime(
      {String id, DateTime start, DateTime end});
}

class DoorRepositoryImpl implements DoorRepository {
  @override
  Future<List<DoorData>> getDoor({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.DOOR}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => DoorData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<DoorData>> getDoorByTime({String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.DOOR}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => DoorData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

}