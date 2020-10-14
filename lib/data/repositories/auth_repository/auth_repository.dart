import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/login_response.dart';
import 'package:lorapark_app/services/dio_service/dio_service.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String username, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      var payload = <String, dynamic>{
        'grant_type': 'password',
        'username': username,
        'password': password,
      };

      var response = await GetIt.I
          .get<DioService>()
          .rawDio
          .post(AUTH_URL, data: payload);

      if(response.statusCode == 200){
        return LoginResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      rethrow;
    }
  }
}
