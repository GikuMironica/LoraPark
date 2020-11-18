import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/data/models/identity.dart';
import 'package:lorapark_app/data/models/login_response.dart';
import 'package:lorapark_app/data/repositories/auth_repository/auth_repository.dart';
import 'package:lorapark_app/services/services.dart';

enum AuthState { NOT_DETERMINED, LOGGED_OUT, LOGGED_IN }

abstract class AuthService extends ChangeNotifier {
  Identity _identity;
  AuthState _authState;

  AuthRepository _authRepository; // ignore: unused_field

  Future<Identity> login(String username, String password);

  Future<void> logout();

  void setIdentity(Identity identity);

  void setAuthState(AuthState authState);

  Future<void> writeTokenToDevice(LoginResponse loginResponse);

  Identity get identity => _identity;

  AuthState get authState => _authState;

  bool get isExpired;
}

class AuthServiceImpl extends ChangeNotifier implements AuthService {
  final Logger _logger = GetIt.I.get<LoggingService>().getLogger((AuthService).toString());

  @override
  Identity _identity;

  @override
  AuthState _authState = AuthState.NOT_DETERMINED;

  @override
  final AuthRepository _authRepository = AuthRepositoryImpl();

  @override
  Future<Identity> login(String username, String password) async {
    var loginResponse =
        await _authRepository.login(username, password);

    if (loginResponse.errors.isEmpty) {
      await writeTokenToDevice(loginResponse).whenComplete(() {
        setIdentity(Identity.fromJWT(loginResponse.accessToken));
        setAuthState(AuthState.LOGGED_IN);
      });
      GetIt.I.get<DioService>().setBearerToken(loginResponse.accessToken);
    } else {
      _logger.e('Unable to login, perhaps check credentials?');
    }
    return null;
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

  /// This function serves no purpose beyond just being here so that dartfmt
  /// does not complain.
  @override
  // ignore: unused_element
  set _authRepository(AuthRepository __authRepository) {
    _authRepository = __authRepository;
  }
}
