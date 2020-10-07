import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show ElectricityData;
import 'package:lorapark_app/services/services.dart' show DioService;
import 'package:lorapark_app/utils/query_builder.dart';

abstract class ElectricityRepository {
  Future<List<ElectricityData>> getElectricity({String id, List<String> ids});

  Future<List<ElectricityData>> getElectricityByTime(
      {String id, DateTime start, DateTime end, List<String> ids});
}

class ElectricityRepositoryImpl implements ElectricityRepository {
  @override
  Future<List<ElectricityData>> getElectricity(
      {String id, List<String> ids}) async {
    try {
      String queryUrl = Endpoints.ELECTRICITY;
      queryUrl =
          ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';

      Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => ElectricityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<ElectricityData>> getElectricityByTime(
      {String id, DateTime start, DateTime end, List<String> ids}) async {
    try {
      String queryUrl = Endpoints.ELECTRICITY;
      queryUrl =
          ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';
      queryUrl =
          '$queryUrl&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}';
      Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => ElectricityData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
