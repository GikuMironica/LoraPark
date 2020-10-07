import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart' show FeedbackButtonData;
import 'package:lorapark_app/services/services.dart' show DioService;

abstract class FeedbackRepository {
  Future<List<FeedbackButtonData>> getFeedbackButton({String id});

  Future<List<FeedbackButtonData>> getFeedbackButtonByTime(
      {String id, DateTime start, DateTime end});
}

class FeedbackRepositoryImpl implements FeedbackRepository {
  @override
  Future<List<FeedbackButtonData>> getFeedbackButton({String id}) async {
    try {
      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .get('${Endpoints.FEEDBACK_BUTTON}?id=$id');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => FeedbackButtonData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<FeedbackButtonData>> getFeedbackButtonByTime(
      {String id, DateTime start, DateTime end}) async {
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(
          '${Endpoints.FEEDBACK_BUTTON}?id=$id&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}');

      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => FeedbackButtonData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
