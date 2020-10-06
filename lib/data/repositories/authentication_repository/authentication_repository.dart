import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/urls.dart';
import 'package:lorapark_app/data/models/login_response.dart';
import 'package:lorapark_app/services/dio_service/dio_service.dart';

abstract class AuthenticationRepository {
  Future<LoginResponse> login(String username, String password);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      Map<String, dynamic> payload = {
        'grant_type': 'password',
        'username': username,
        'password': password,
      };

      Response response = await GetIt.I
          .get<DioService>()
          .dio
          .post(apiUrls['login'], data: payload);

      if(response.statusCode == 200){
        return LoginResponse.fromJson(response.data);
      }
    } on DioError catch (e) {

    }
  }
}
