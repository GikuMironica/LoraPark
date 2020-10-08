import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/services/services.dart';
import 'package:lorapark_app/utils/query_builder.dart';

class BaseSensorRepository {
  String get endpoint => '';

  Future get({String id, List<String> ids}) async {
    String query =
        ids == null ? '$endpoint?id=$id' : '$endpoint${queryBuilder(ids)}';
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(query);
      return response.statusCode == 200 ? response.data : null;
    } on DioError catch (e) {
      return null;
    }
  }

  Future getByTime(
      {String id,
      List<String> ids,
      @required DateTime start,
      @required DateTime end}) async {
    String query =
        ids == null ? '$endpoint?id=$id' : '$endpoint${queryBuilder(ids)}';
    query = '$query${timeQueryBuilder(start, end)}';
    try {
      Response response = await GetIt.I.get<DioService>().dio.get(query);
      return response.statusCode == 200 ? response.data : null;
    } on DioError catch (e) {
      return null;
    }
  }
}
