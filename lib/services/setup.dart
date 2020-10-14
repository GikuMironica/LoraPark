import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/consts.dart';

import 'services.dart';

final getIt = GetIt.instance;

void servicesSetup() {
  getIt.registerSingleton<LoggingService>(LoggingService(enableColors: LOG_COLORS));
  getIt.registerSingleton<DioService>(DioService());
  getIt.registerSingleton<SecureService>(SecureService());
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
}