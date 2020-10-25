import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/credentials.dart';
import 'package:lorapark_app/config/dio_config.dart';
import 'package:lorapark_app/services/services.dart'
    show LoggingService, AuthService, AuthState;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:io';

class DioService {
  static DioService _dioService;
  Dio _dio;
  Dio _rawDio;
  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((DioService).toString());

  Dio get dio => _dio;

  Dio get rawDio => _rawDio;

  factory DioService() {
    return _dioService ??= DioService._();
  }

  void setBearerToken(String token) {
    _dio.options.headers
        .addAll({HttpHeaders.authorizationHeader: 'bearer $token'});
    _logger.d('Bearer token set');
  }

  DioService._() {
    _rawDio = Dio()..interceptors.add(PrettyDioLogger());
    _dio = Dio(LoraParkOptions())
      // Development purposes
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          responseHeader: true,
          responseBody: false
        ),
        InterceptorsWrapper(onError: (DioError error) async {
          if (error.response?.statusCode == 403) {
            var _authService = GetIt.I.get<AuthService>();
            if (_authService.authState == AuthState.LOGGED_IN &&
                _authService.isExpired) {
              var requestOptions = error.response.request;
              await _authService
                  .login(credentials['username'], credentials['password'])
                  .whenComplete(() => _dio.request(requestOptions.path));
            }
          }
        })
      ]);
  }
}
