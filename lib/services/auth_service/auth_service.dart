import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/data/models/identity.dart';
import 'package:lorapark_app/data/models/login_response.dart';
import 'package:lorapark_app/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:lorapark_app/services/dio_service/dio_service.dart';
import 'package:lorapark_app/services/secure_service/secure_service.dart';

enum AuthState { NOT_DETERMINED, LOGGED_OUT, LOGGED_IN }

abstract class AuthService extends ChangeNotifier {
  Identity _identity;
  AuthState _authState;
  AuthenticationRepository _authRepository;

  Future<Identity> login(String username, String password);

  Future<void> logout();

  void setIdentity(Identity identity);

  void setAuthState(AuthState authState);

  Future<void> writeTokenToDevice(LoginResponse loginResponse);

  Identity get identity;

  AuthState get authState;

  bool get isExpired;
}

class AuthServiceImpl extends ChangeNotifier implements AuthService {
  @override
  Identity _identity;

  @override
  AuthState _authState = AuthState.NOT_DETERMINED;

  AuthenticationRepository _authRepository = AuthenticationRepositoryImpl();

  @override
  Future<Identity> login(String username, String password) async {
    LoginResponse loginResponse =
        await _authRepository.login(username, password);

    if (loginResponse.errors.isEmpty) {
      await writeTokenToDevice(loginResponse).whenComplete(() {
        setIdentity(Identity.fromJWT(loginResponse.accessToken));
        setAuthState(AuthState.LOGGED_IN);
      });
      GetIt.I.get<DioService>().setBearerToken(loginResponse.accessToken);
    } else {
      print('Error trying to log in, check credentials!!');
    }
  }

  @override
  Future<void> logout() async {
    await GetIt.I.get<SecureService>().secureStorage.deleteAll();
    setIdentity(null);
    setAuthState(AuthState.LOGGED_OUT);
  }

  @override
  Future<void> writeTokenToDevice(LoginResponse loginResponse) async {
    await GetIt.I
        .get<SecureService>()
        .secureStorage
        .write(key: 'access_token', value: loginResponse.accessToken);
    await GetIt.I
        .get<SecureService>()
        .secureStorage
        .write(key: 'refresh_token', value: loginResponse.refreshToken);
  }

  @override
  void setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  @override
  void setIdentity(Identity identity) {
    _identity = identity;
    notifyListeners();
  }

  @override
  Identity get identity => _identity;

  @override
  AuthState get authState => _authState;

  @override
  bool get isExpired => DateTime.now().isAfter(_identity.expiry);
}
