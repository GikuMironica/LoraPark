import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/sensors.dart'
    show CurrentParkingStateData, ParkingEventData, ParkingAverageDurationData;
import 'package:lorapark_app/data/repositories/sensor_repository/base_sensor_repository.dart';
import 'package:flutter/material.dart' show required;

class ParkingStateRepository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.PARKING_STATE;

  List<CurrentParkingStateData> convert(Iterable it) {
    return it.map((e) => CurrentParkingStateData.fromJson(e)).toList();
  }

  @override
  Future<List<CurrentParkingStateData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<CurrentParkingStateData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
}

// class ParkingHistoryRepository extends BaseSensorRepository{
//   @override
//   String get endpoint => Endpoints.PARKING_HISTORY;
//
//   List<ParkingHistoryData> convert(Iterable it) {
//     return it.map((e) => ParkingHistoryData.fromJson(e)).toList();
//   }
//
//   @override
//   Future<List<ParkingHistoryData>> get({String id, List<String> ids}) async {
//     return convert(await super.get(id: id, ids: ids));
//   }
//
//   @override
//   Future<List<ParkingHistoryData>> getByTime(
//       {String id,
//         List<String> ids,
//         @required DateTime start,
//         @required DateTime end}) async {
//     return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
//   }
// }

class ParkingAverageRepository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.PARKING_AVERAGE_DURATION;

  List<ParkingAverageDurationData> convert(Iterable it) {
    return it.map((e) => ParkingAverageDurationData.fromJson(e)).toList();
  }

  @override
  Future<List<ParkingAverageDurationData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<ParkingAverageDurationData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
  
}

class ParkingEventRepository extends BaseSensorRepository {
  @override
  String get endpoint => Endpoints.PARKING_EVENTS;

  List<ParkingEventData> convert(Iterable it) {
    return it.map((e) => ParkingEventData.fromJson(e)).toList();
  }

  @override
  Future<List<ParkingEventData>> get({String id, List<String> ids}) async {
    return convert(await super.get(id: id, ids: ids));
  }

  @override
  Future<List<ParkingEventData>> getByTime(
      {String id,
        List<String> ids,
        @required DateTime start,
        @required DateTime end}) async {
    return convert(await super.getByTime(id: id, ids: ids, start: start, end: end));
  }
  
}