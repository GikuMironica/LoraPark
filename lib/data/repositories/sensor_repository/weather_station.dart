import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show WeatherStationData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class WeatherStationRepository {
  Future<List<WeatherStationData>> getWeatherStation({String id});

  Future<List<WeatherStationData>> getWeatherStationByTime(
      {String id, DateTime start, DateTime end});
}

class WeatherStationRepositoryImpl implements WeatherStationRepository {
  @override
  Future<List<WeatherStationData>> getWeatherStation({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.WEATHER_STATION}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => WeatherStationData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<WeatherStationData>> getWeatherStationByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.WEATHER_STATION}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => WeatherStationData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
