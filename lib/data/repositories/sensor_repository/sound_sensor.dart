import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show SoundSensorData;
import 'package:lorapark_app/services/services.dart';

abstract class SoundSensorRepository {
  Future<List<SoundSensorData>> getSoundSensor({String id});

  Future<List<SoundSensorData>> getSoundSensorByTime(
      {String id, DateTime start, DateTime end});
}

class SoundSensorRepositoryImpl implements SoundSensorRepository {
  @override
  Future<List<SoundSensorData>> getSoundSensor({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.SOUND_SENSOR}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => SoundSensorData.fromJson(e)).toList();
      }
    } on DioError catch (e) {};
  }

  @override
  Future<List<SoundSensorData>> getSoundSensorByTime({String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.SOUND_SENSOR}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => SoundSensorData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

}