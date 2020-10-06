import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/credentials.dart';
import 'package:lorapark_app/config/dio_config.dart';
import 'package:lorapark_app/services/auth_service/auth_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:io';

class DioService {
  static DioService _dioService;
  Dio _dio;

  Dio get dio => _dio;

  factory DioService() {
    return _dioService ??= DioService._();
  }

  void setBearerToken(String token) {
    _dio.options.headers
        .addAll({HttpHeaders.authorizationHeader: 'bearer $token'});
  }

  DioService._() {
    _dio = Dio(LoraParkOptions())
      // Development purposes
      ..interceptors.addAll([
        PrettyDioLogger(),
        InterceptorsWrapper(onError: (DioError error) async {
          if (error.response?.statusCode == 403) {
            AuthService _authService = GetIt.I.get<AuthService>();
            if (_authService.authState == AuthState.LOGGED_IN &&
                _authService.isExpired) {
              RequestOptions requestOptions = error.response.request;
              await _authService
                  .login(credentials['username'], credentials['password'])
                  .whenComplete(() => _dio.request(requestOptions.path));
            }
          }
        })
      ]);
  }
}
