import 'package:lorapark_app/data/models/identity.dart';

class LoginResponse {
  String _accessToken;
  String _tokenType;
  int _expiry;
  String _refreshToken;
  int _refreshTokenExpiresAt;
  List<String> errors = [];

  LoginResponse({String accessToken, String tokenType, int expiry, String refreshToken, int refreshTokenExpiry}){
    _accessToken = accessToken;
    _tokenType = tokenType;
    _expiry = expiry;
    _refreshToken = refreshToken;
    _refreshTokenExpiresAt = refreshTokenExpiry;
  }

  LoginResponse.withError({this.errors});

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiry: json['expires_in'],
      refreshToken: json['refresh_token'],
      refreshTokenExpiry: json['refresh_token_expires_at'],
    );
  }

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}