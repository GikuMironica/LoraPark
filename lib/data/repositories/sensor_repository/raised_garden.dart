import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show RaisedGardenData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class RaisedGardenRepository {
  Future<List<RaisedGardenData>> getRaisedGarden({String id});

  Future<List<RaisedGardenData>> getRaisedGardenByTime(
      {String id, DateTime start, DateTime end});
}

class RaisedGardenRepositoryImpl implements RaisedGardenRepository {
  @override
  Future<List<RaisedGardenData>> getRaisedGarden({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.RAISED_GARDEN}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => RaisedGardenData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<RaisedGardenData>> getRaisedGardenByTime({String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.RAISED_GARDEN}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => RaisedGardenData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

}
