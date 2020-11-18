import 'dart:convert';
import 'package:collection/collection.dart';
import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/data/models/coordinates.dart';
import 'package:lorapark_app/data/models/sensor.dart';
import 'package:lorapark_app/data/models/sensor_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/air_quality.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/door.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/energy.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/flood_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/ground_humidity.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/person_count.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/raised_garden.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/rat.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/sensor_repository.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

enum NavBottomSheetState { SHOWING, HIDDEN }

class ARController extends ChangeNotifier {
  AirQualityRepository _airQualityRepository;
  DoorRepository _doorRepository;
  EnergyDataRepository _energyDataRepository;
  FloodDataRepository _floodDataRepository;
  GroundHumidityRepository _groundHumidityRepository;
  PersonCountRepository _personCountRepository;
  RaisedGardenRepository _raisedGardenRepository;
  StructureDamageRepository _structureDamageRepository;
  WasteLevelRepository _wasteLevelRepository;
  WeatherStationRepository _weatherStationRepository;
  RatRepository _ratRepository;
  SoundSensorRepository _soundSensorRepository;

  NavBottomSheetState _bottomSheetState;

  NavBottomSheetState get bottomSheetState => _bottomSheetState;

  String _jsonConfig = '';
  static final MAX_LENGTH = 132;
  static final MIN_LENGTH = 30;
  static final FILL_RATIO_THRESHOLD = 75;
  static final int NO_LIMIT = 127;
  static final int NO2_LIMIT = 101;
  static final int CO_LIMIT = 87;
  UnityWidgetController _unityWidgetController;
  final Sensors _sensorList = GetIt.I.get<Sensors>();
  Map<String, dynamic> sensorsData = {};
  bool configReady = false;
  bool unityReady = false;
  bool dataSent = false;
  bool navigationActive = false;
  int navigationTo;

  final Logger _logger = GetIt.I
      .get<LoggingService>()
      .getLogger((AirQualityRepository).toString());

  ARController(
      {@required AirQualityRepository airQualityRepository,
      @required DoorRepository doorRepository,
      @required EnergyDataRepository energyDataRepository,
      @required FloodDataRepository floodDataRepository,
      @required GroundHumidityRepository groundHumidityRepository,
      @required PersonCountRepository personCountRepository,
      @required RaisedGardenRepository raisedGardenRepository,
      @required StructureDamageRepository structureDamageRepository,
      @required WasteLevelRepository wasteLevelRepository,
      @required WeatherStationRepository weatherStationRepository,
      @required RatRepository ratRepository,
      @required SoundSensorRepository soundSensorRepository}) {
    _airQualityRepository = airQualityRepository;
    _doorRepository = doorRepository;
    _energyDataRepository = energyDataRepository;
    _floodDataRepository = floodDataRepository;
    _groundHumidityRepository = groundHumidityRepository;
    _personCountRepository = personCountRepository;
    _raisedGardenRepository = raisedGardenRepository;
    _structureDamageRepository = structureDamageRepository;
    _wasteLevelRepository = wasteLevelRepository;
    _weatherStationRepository = weatherStationRepository;
    _ratRepository = ratRepository;
    _soundSensorRepository = soundSensorRepository;
    init();
  }

  void init() {
    _bottomSheetState = NavBottomSheetState.HIDDEN;
    getActualData()
        .whenComplete(() => createJsonConfig())
        .whenComplete(() => configReady = true);
  }

  void setBottomSheetState(NavBottomSheetState newState) {
    _bottomSheetState = newState;
    notifyListeners();
  }

  Future<void> getActualData() async {
    _logger.d('Fetching air quality data');
    sensorsData[describeEnum(SensorType.air_quality).toString()] =
        await _airQualityRepository.get(id: SensorEndpoints.airQuality_one);
    _logger.d('Fetching door data');
    sensorsData[describeEnum(SensorType.door).toString()] =
        await _doorRepository.get(id: SensorEndpoints.door_one);
    _logger.d('Fetching energy data');
    sensorsData[describeEnum(SensorType.energy).toString()] =
        await _energyDataRepository.get(id: SensorEndpoints.energyData_two);
    _logger.d('Fetching flood data');
    sensorsData[describeEnum(SensorType.flood_data).toString()] =
        await _floodDataRepository.get(id: SensorEndpoints.floodData);
    _logger.d('Fetching ground humidity data');
    sensorsData[describeEnum(SensorType.ground_humidity).toString()] =
        await _groundHumidityRepository.get(
            id: SensorEndpoints.groundHumidity_one);
    _logger.d('Fetching person count data');
    sensorsData[describeEnum(SensorType.person_count).toString()] =
        await _personCountRepository.get(id: SensorEndpoints.personCount_one);
    _logger.d('Fetching  raised garden data');
    sensorsData[describeEnum(SensorType.raised_garden).toString()] =
        await _raisedGardenRepository.get(id: SensorEndpoints.raisedGarden);
    _logger.d('Fetching structure damage data');
    sensorsData[describeEnum(SensorType.structure_damage).toString()] =
        await _structureDamageRepository.get(
            id: SensorEndpoints.structureDamage);
    _logger.d('Fetching waste level data');
    sensorsData[describeEnum(SensorType.waste_level).toString()] =
        await _wasteLevelRepository.get(id: SensorEndpoints.wasteLevel);
    _logger.d('Fetching weather station data');
    sensorsData[describeEnum(SensorType.weather_station).toString()] =
        await _weatherStationRepository.get(
            id: SensorEndpoints.weatherStation_one);
    _logger.d('Fetching rat sensor data');
    sensorsData[describeEnum(SensorType.rat_sensor).toString()] =
        await _ratRepository.get();
    _logger.d('Fetching sound sensor data');
    sensorsData[describeEnum(SensorType.sound_sensor).toString()] =
        await _soundSensorRepository.get(id: SensorEndpoints.soundSensor_one);
  }

  void createJsonConfig() {
    var sensorGroups =
        groupBy(_sensorList.list, (sensor) => sensor.sensorLocation);
    _jsonConfig = _jsonConfig + '[';
    for (SensorLocation sensorKey in sensorGroups.keys) {
      _jsonConfig = _jsonConfig +
          '{"location": ' +
          jsonEncode(sensorKey.toJSON()) +
          ',' +
          '"data" :[';
      for (var sensor in sensorGroups[sensorKey]) {
        switch (describeEnum(sensor.type)) {
          case 'weather_station':
            _jsonConfig = _jsonConfig +
                '{"name": "Temperature",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .temperature
                    .toString() +
                ' °C"},';
            break;
          case 'person_count':
            _jsonConfig = _jsonConfig +
                '{"name": "Number of people",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .paxCount
                    .toString() +
                ' people"},';
            break;
          case 'door':
            _jsonConfig = _jsonConfig +
                '{"name": "Number of openings",'
                    ' "value": "' +
                getTotalDailyNumberOfOpenings(
                        DateTime.now(), sensorsData[describeEnum(sensor.type)])
                    .toString() +
                '"},' +
                '{"name": "Last time opened",'
                    ' "value": "' +
                getLastOpeningTime(
                        doorData: sensorsData[describeEnum(sensor.type)])
                    .toString() +
                '"},';
            break;
          case 'energy':
            _jsonConfig = _jsonConfig +
                '{"name": "Temperature of Incoming Water",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .flowTemperature
                    .toString() +
                ' °C"},' +
                '{"name": "Temperature of Outgoing Water",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .returnTemperature
                    .toString() +
                ' °C"},';
            break;
          case 'flood_data':
            _jsonConfig = _jsonConfig +
                '{"name": "Current Distance",'
                    ' "value": "' +
                (sensorsData[describeEnum(sensor.type)].first.distance / 10.0)
                    .toString() +
                ' cm"},';
            break;
          case 'ground_humidity':
            _jsonConfig = _jsonConfig +
                '{"name": "Volumetric Water Content",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)].first.vwc.toString() +
                ' %"},' +
                '{"name": "Ground Temperature",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .temperature
                    .toString() +
                ' °C"},';
            break;
          case 'raised_garden':
            _jsonConfig = _jsonConfig +
                '{"name": "Water tank state",'
                    ' "value": "' +
                (sensorsData[describeEnum(sensor.type)].first.watertankEmpty ==
                            1
                        ? "Empty"
                        : "Full")
                    .toString() +
                ' "},' +
                '{"name": "Ground Humidity",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .humidity
                    .toString() +
                ' %"},';
            break;
          case 'waste_level':
            _jsonConfig = _jsonConfig +
                '{"name": "Current State",'
                    ' "value": "' +
                getPercentFull(sensorsData[describeEnum(sensor.type)])
                    .toStringAsFixed(0) +
                ' % full"},';
            break;
          case 'air_quality':
            _jsonConfig = _jsonConfig +
                '{"name": "Air Quality",'
                    ' "value": "' +
                getAirQualityLevel(sensorsData[describeEnum(sensor.type)])
                    .toString() +
                '"},';
            break;
          case 'structure_damage':
            _jsonConfig = _jsonConfig +
                '{"name": "Current Distance",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .distance
                    .toString() +
                ' mm"},';
            break;
          case 'parking':
            break;
          case 'rat_sensor':
            _jsonConfig = _jsonConfig +
                '{"name": "Number of rat visits",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .visits[sensorsData[describeEnum(sensor.type)]
                            .visits
                            .length -
                        1]
                    .y
                    .toString() +
                '"},';
            break;
          case 'sound_sensor':
            _jsonConfig = _jsonConfig +
                '{"name": "Traffic noise",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .firstdbaslow
                    .toStringAsFixed(2) +
                ' dba"},' +
                '{"name": "Sound pressure",'
                    ' "value": "' +
                sensorsData[describeEnum(sensor.type)]
                    .first
                    .firstleqa
                    .toStringAsFixed(2) +
                ' dba"},';
            break;
          default:
            print('Not a known animal.:' + sensor.type.toString());
        }
      }
      _jsonConfig = _jsonConfig + '],},';
    }
    _jsonConfig = _jsonConfig + ']';
    _logger.d('unity json config: ' + _jsonConfig);
    configReady = false;
    if (unityReady && !dataSent) {
      SendDataToUnity();
    }
    ;
  }

  int getTotalDailyNumberOfOpenings(DateTime date, List<DoorData> doorData) {
    return doorData
        .where((e) =>
            e.timestamp.year == date.year &&
            e.timestamp.month == date.month &&
            e.timestamp.day == date.day &&
            e.extDigital == 1)
        .length;
  }

  String getLastOpeningTime(
      {String timeFormat = 'H:mm', List<DoorData> doorData}) {
    var date = doorData.firstWhere((e) => e.extDigital == 1).timestamp;
    var formatter = DateFormat(timeFormat);
    return formatter.format(date);
  }

  double getPercentFull(List<WasteLevelData> wasteLevelData) {
    return (wasteLevelData
                .where((e) => _getFillRatio(e.length) > FILL_RATIO_THRESHOLD)
                .length /
            wasteLevelData.length *
            100)
        .round()
        .toDouble();
  }

  double _getFillRatio(int length) {
    return min((MAX_LENGTH - length).abs(), (MAX_LENGTH - MIN_LENGTH)) /
        (MAX_LENGTH - MIN_LENGTH) *
        100;
  }

  // Communcation from Flutter to Unity
  void SendDataToUnity() async {
    _unityWidgetController.postMessage(
        'Sensors', 'LoadLocationObjects', _jsonConfig);
  }

  void navigateInUnity(Sensor sensor) async {
    navigationActive = true;
    var destination =
        '[{"location": ' + jsonEncode(sensor.location.toJSON()) + '}]';
    _unityWidgetController.postMessage(
        'Pointer', 'NavigateToSensor', destination);
  }

  void setNavigationTo(int index) {
    navigationTo = index;
    if (index != null) {
      navigateInUnity(_sensorList.list[index]);
    } else {
      stopNavigation();
    }
    notifyListeners();
  }

  void stopNavigation() async {
    navigationActive = false;
    _unityWidgetController.postMessage('Pointer', 'StopNavigation', 'Stop');
  }

  // Communication from Unity to Flutter
  void onUnityMessage(controller, message) {
    _logger.d('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
    unityReady = true;
    if (configReady && !dataSent) {
      SendDataToUnity();
    }
    ;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(
    controller, {
    int buildIndex,
    bool isLoaded,
    bool isValid,
    String name,
  }) {
    _logger.d('Received scene loaded from unity: $name');
    _logger.d('Received scene loaded from unity buildIndex: $buildIndex');
  }

  String getAirQualityLevel(List<AirQualityData> _data) {
    var sumViolated = 0;
    _data.forEach((d) {
      if (d.noConcentration > NO_LIMIT ||
          d.no2Concentration > NO2_LIMIT ||
          d.coConcentration > CO_LIMIT) {
        sumViolated++;
      }
    });

    var airQualityLevel = '';
    if (sumViolated > 10) {
      airQualityLevel = 'Bad';
    } else if (sumViolated > 5) {
      airQualityLevel = 'Medium';
    } else {
      airQualityLevel = 'Good';
    }

    return airQualityLevel;
  }

  String get jsonConfig => _jsonConfig;

  UnityWidgetController get unityWidgetController => _unityWidgetController;

  Sensors get sensorList => _sensorList;
}
