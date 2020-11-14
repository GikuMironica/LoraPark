import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/controller/ocr_controller/ocr_controller.dart';
import 'package:lorapark_app/controller/search_controller/sensor_search_controller.dart';
import 'package:lorapark_app/controller/settings_controller/settings_controller.dart';
import 'package:lorapark_app/data/models/coordinates.dart';
import 'package:lorapark_app/services/location_service/location_service.dart';
import 'package:lorapark_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'controller/controllers.dart';
import 'data/repositories/sensor_repository/sensor_repository.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<AuthService>(
      create: (_) => GetIt.I.get<AuthService>()),
  ChangeNotifierProvider(
    create: (_) =>
        SettingsController(repository: GetIt.I.get<PersonCountRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => WeatherStationController(
        repository: GetIt.I.get<WeatherStationRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => GrouundHumidityController(
        repository: GetIt.I.get<GroundHumidityRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => RaisedGardenController(
        repository: GetIt.I.get<RaisedGardenRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) =>
        AirQualityController(repository: GetIt.I.get<AirQualityRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => WasteLevelController(
      repository: GetIt.I.get<WasteLevelRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => DoorController(
      repository: GetIt.I.get<DoorRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => StructureDamageController(
      repository: GetIt.I.get<StructureDamageRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => ParkingSensorController(
        stateRepo: GetIt.I.get<ParkingStateRepository>(),
        avgRepo: GetIt.I.get<ParkingAverageRepository>(),
        eventRepo: GetIt.I.get<ParkingEventRepository>()),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => PersonCountController(
      repository: GetIt.I.get<PersonCountRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => EnergyDataController(
      repository: GetIt.I.get<EnergyDataRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => FloodDataController(
      repository: GetIt.I.get<FloodDataRepository>(),
    ),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => SensorSearchController(sensors: GetIt.I.get<Sensors>().list),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => OcrController(),
    lazy: true,
  ),
  StreamProvider<UserLocation>.value(value: GetIt.I.get<LocationService>().locationStream,)
];
