import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/data/models/sensors/rat_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:lorapark_app/services/dio_service/dio_service.dart';

abstract class RatRepository extends BaseSensorRepository {}

class RatRepositoryImpl extends RatRepository {}

class RatRepositoryMock extends RatRepository {
  Future<RatData> get({String id, List<String> ids}) async {
    final url = 'https://sensoren.lorapark.de/api/ballb';
    try {
      var response = await GetIt.I.get<DioService>().rawDio.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> it = response.data;
        Iterable visitData = it['visits'];
        var vList = visitData.map((e) => RatVisitData.fromJson(e)).toList();
        return RatData(
            decoy: it['decoyDay'][0],
            poison: it['poisonDay'][0],
            visits: vList);
      }
    } on DioError catch (E) {
      logger.e('Something went wrong');
    }
  }
}
