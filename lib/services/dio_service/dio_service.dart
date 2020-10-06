import 'package:dio/dio.dart';
import 'package:lorapark_app/config/dio_config.dart';

class DioService {
  static DioService _dioService;
  Dio _dio;

  factory DioService(){
    return _dioService ??= DioService._();
  }

  DioService._(){
    _dio = Dio(LoraParkOptions());
  }
}