import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensor_data.dart' show FeedbackButtonData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

abstract class FeedbackRepository extends BaseSensorRepository{

}

class FeedbackRepositoryImpl extends FeedbackRepository{
  @override
  String get endpoint => Endpoints.FEEDBACK_BUTTON;

  List<FeedbackButtonData> convert(Iterable it) {
    return it.map((e) => FeedbackButtonData.fromJson(e)).toList();
  }

  @override
  Future<List<FeedbackButtonData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<FeedbackButtonData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}
