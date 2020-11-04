import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/consts.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/air_quality.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/flood_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/sensor_repository.dart';
import 'package:lorapark_app/services/location_service/location_service.dart';

import 'services.dart';

final getIt = GetIt.instance;

void servicesSetup({bool isProductionEnv}) {
  getIt.registerSingleton<LoggingService>(
      LoggingService(enableColors: LOG_COLORS));
  getIt.registerSingleton<DioService>(DioService());
  getIt.registerSingleton<SecureService>(SecureService());
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
  getIt.registerSingleton<LocationService>(LocationService());
  getIt.registerSingleton<Sensors>(Sensors());
  if (isProductionEnv) {
    getIt.registerSingleton<AirQualityRepository>(AirQualityRepositoryImpl());
    getIt.registerSingleton<CO2Repository>(CO2RepositoryImpl());
    getIt.registerSingleton<DoorRepository>(DoorRepositoryImpl());
    getIt.registerSingleton<ElectricityRepository>(ElectricityRepositoryImpl());
    getIt.registerSingleton<FeedbackRepository>(FeedbackRepositoryImpl());
    getIt.registerSingleton<FloodDataRepository>(FloodDataRepositoryImpl());
    getIt.registerSingleton<GroundHumidityRepository>(
        GroundHumidityRepositoryImpl());
    getIt.registerSingleton<ParkingStateRepository>(ParkingStateRepositoryImpl());
    getIt.registerSingleton<ParkingAverageRepository>(
        ParkingAverageRepositoryImpl());
    getIt.registerSingleton<ParkingEventRepository>(ParkingEventRepositoryImpl());
    getIt.registerSingleton<PersonCountRepository>(PersonCountRepositoryImpl());
    getIt.registerSingleton<RaisedGardenRepository>(
        RaisedGardenRepositoryImpl());
    getIt.registerSingleton<SoundSensorRepository>(SoundSensorRepositoryImpl());
    getIt.registerSingleton<StructureDamageRepository>(
        StructureDamageRepositoryImpl());
    getIt.registerSingleton<WasteLevelRepository>(WasteLevelRepositoryImpl());
    getIt.registerSingleton<WeatherStationRepository>(
        WeatherStationRepositoryImpl());
    getIt.registerSingleton<EnergyDataRepository>(EnergyDataRepositoryImpl());
  }
}
