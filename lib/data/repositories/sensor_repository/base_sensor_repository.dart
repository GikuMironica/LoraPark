import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/services/services.dart'
    show LoggingService, DioService;
import 'package:lorapark_app/utils/query_builder.dart';


abstract class BaseSensorRepository {
  Logger get logger =>
      GetIt.I.get<LoggingService>().getLogger((runtimeType).toString());

  String get endpoint => '';

  Future get({String id, List<String> ids}) async {
    var query =
        ids == null ? '$endpoint?id=$id' : '$endpoint${queryBuilder(ids)}';
    try {
      var response = await GetIt.I.get<DioService>().dio.get(query);
      return response.statusCode == 200 ? response.data : null;
    } on DioError catch (e) {
      logger.e(e.message);
    }
  }

  Future getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    var query =
        ids == null ? '$endpoint?id=$id' : '$endpoint${queryBuilder(ids)}';
    query = '$query${timeQueryBuilder(start, end)}';
    try {
      var response = await GetIt.I.get<DioService>().dio.get(query);
      return response.statusCode == 200 ? response.data : null;
    } on DioError catch (e) {
      logger.e(e.message);
    }
  }
}
