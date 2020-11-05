import 'package:flutter/cupertino.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/parking.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/services/services.dart' show LoggingService;

class ParkingSensorController extends ChangeNotifier {
  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((ParkingSensorController).toString());
  final ScrollController _scrollController = ScrollController();

  ParkingStateRepository _stateRepository;
  ParkingAverageRepository _averageRepository;
  ParkingEventRepository _eventRepo;

  List<CurrentParkingStateData> _data = [];
  List<ParkingAverageDurationData> _avgData = [];
  List<ParkingEventData> _eventData = [];

  //ninja code, assignment
  ParkingSensorController(
      {ParkingStateRepository stateRepo,
      ParkingAverageRepository avgRepo,
      ParkingEventRepository eventRepo}) {
    _stateRepository = stateRepo;
    _averageRepository = avgRepo;
    _eventRepo = eventRepo;
    init();
  }

  void init() {
    getParkingEvents(7);
    getParkingAverageDuration(7);
  }

  Future<void> getCurrentParkingByTime(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _data = await _stateRepository.getByTime(
      id: SensorEndpoints.parking_one,
      start: startDate,
      end: endDate,
    );

    notifyListeners();
  }

  Future<void> getParkingAverageDuration(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _avgData = await _averageRepository.getByTime(ids: [
      SensorEndpoints.parking_one,
      SensorEndpoints.parking_two,
      SensorEndpoints.parking_three,
      SensorEndpoints.parking_four
    ], start: startDate, end: endDate);
    _logger.d(_avgData);
    notifyListeners();
  }

  Future<void> getParkingEvents(int days) async {
    var endDate = DateTime.now();
    var startDate = endDate.subtract(Duration(days: days));
    _logger.d('Fetching data');
    _eventData = await _eventRepo.getByTime(ids: [
      SensorEndpoints.parking_one,
      SensorEndpoints.parking_two,
      SensorEndpoints.parking_three,
      SensorEndpoints.parking_four
    ], start: startDate, end: endDate);

    notifyListeners();
  }

  //getters for current parking state
  int get occupiedPlace => _data.first.occupied;

  int get occupied => _data.first.occupied;

  List<CurrentParkingStateData> get data => _data;

  //getters for averageDuration state
  List<ParkingAverageDurationData> get dataAvg => _avgData;

  int get avgParkingDuration => _avgData.first.averageParkingDuration;

  //getters for parkingEvents
  List<ParkingEventData> get parkingEventData => _eventData;

  int get parkingEvents => _eventData.first.parkingEvents;

  ScrollController get scrollController => _scrollController;
}
