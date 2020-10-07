import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show PersonCountData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class PersonCountRepository {
  Future<List<PersonCountData>> getPersonCount({String id});

  Future<List<PersonCountData>> getPersonCountByTime(
      {String id, DateTime start, DateTime end});
}

class PersonCountRepositoryImpl implements PersonCountRepository {
  @override
  Future<List<PersonCountData>> getPersonCount({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.PERSON_COUNT}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => PersonCountData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<PersonCountData>> getPersonCountByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.PERSON_COUNT}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => PersonCountData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
