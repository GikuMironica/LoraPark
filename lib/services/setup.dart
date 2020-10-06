import 'package:get_it/get_it.dart';

import 'services.dart';

final getIt = GetIt.instance;

void servicesSetup() {
  getIt.registerSingleton<DioService>(DioService());
  getIt.registerSingleton<SecureService>(SecureService());
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
}