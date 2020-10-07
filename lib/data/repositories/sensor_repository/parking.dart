import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart'
    show CurrentParkingStateData, ParkingEventData, ParkingAverageDurationData;
import 'package:lorapark_app/services/services.dart';
import 'package:lorapark_app/utils/query_builder.dart';

abstract class ParkingRepository {
  Future<List<CurrentParkingStateData>> getCurrentParkingState(
      {String id, List<String> ids});

  Future<List<CurrentParkingStateData>> getCurrentParkingStateByTime(
      {String id, DateTime start, DateTime end, List<String> ids});

  Future<List<ParkingEventData>> getParkingEvent({String id, List<String> ids});

  Future<List<ParkingEventData>> getParkingEventByTime(
      {String id, DateTime start, DateTime end, List<String> ids});

  Future<List<ParkingAverageDurationData>> getParkingAverageDuration(
      {String id, List<String> ids});

  Future<List<ParkingAverageDurationData>> getParkingAverageDurationByTime(
      {String id, DateTime start, DateTime end, List<String> ids});

// Future<List<ParkingHistoryData>> getParkingHistory({String id, int slot = 30});
// Future<List<ParkingHistoryData>> getParkingHistoryByTime({String id, int slot = 30, DateTime start, DateTime end});
}

class ParkingRepositoryImpl implements ParkingRepository {
  @override
  Future<List<CurrentParkingStateData>> getCurrentParkingState(
      {String id, List<String> ids}) async {
    String queryUrl = Endpoints.PARKING_STATE;
    queryUrl =
        ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';

    Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
    if (response.statusCode == 200) {
      Iterable it = response.data;
      return it.map((e) => CurrentParkingStateData.fromJson(e)).toList();
    }
  }

  @override
  Future<List<CurrentParkingStateData>> getCurrentParkingStateByTime(
      {String id, DateTime start, DateTime end, List<String> ids}) async {
    try {
      String queryUrl = Endpoints.PARKING_STATE;
      queryUrl =
      ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';
      queryUrl =
      '$queryUrl&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}';
      Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => CurrentParkingStateData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<ParkingAverageDurationData>> getParkingAverageDuration(
      {String id, List<String> ids}) async {
    String queryUrl = Endpoints.PARKING_AVERAGE_DURATION;
    queryUrl =
        ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';

    Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
    if (response.statusCode == 200) {
      Iterable it = response.data;
      return it.map((e) => ParkingAverageDurationData.fromJson(e)).toList();
    }
  }

  @override
  Future<List<ParkingAverageDurationData>> getParkingAverageDurationByTime(
      {String id, DateTime start, DateTime end, List<String> ids}) async {
    try {
      String queryUrl = Endpoints.PARKING_AVERAGE_DURATION;
      queryUrl =
      ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';
      queryUrl =
      '$queryUrl&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}';
      Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => ParkingAverageDurationData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }

  @override
  Future<List<ParkingEventData>> getParkingEvent(
      {String id, List<String> ids}) async {
    String queryUrl = Endpoints.PARKING_EVENTS;
    queryUrl =
        ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';

    Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
    if (response.statusCode == 200) {
      Iterable it = response.data;
      return it.map((e) => ParkingEventData.fromJson(e)).toList();
    }
  }

  @override
  Future<List<ParkingEventData>> getParkingEventByTime(
      {String id, DateTime start, DateTime end, List<String> ids}) async {
    try {
      String queryUrl = Endpoints.PARKING_EVENTS;
      queryUrl =
          ids == null ? '$queryUrl?id=$id' : '$queryUrl${queryBuilder(ids)}';
      queryUrl =
          '$queryUrl&start=${start.toUtc().toIso8601String()}&end=${end.toUtc().toIso8601String()}';
      Response response = await GetIt.I.get<DioService>().dio.get(queryUrl);
      if (response.statusCode == 200) {
        Iterable it = response.data;
        return it.map((e) => ParkingEventData.fromJson(e)).toList();
      }
    } on DioError catch (e) {}
  }
}
