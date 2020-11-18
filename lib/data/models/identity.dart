import 'package:jwt_decode/jwt_decode.dart';
import 'package:lorapark_app/data/models/login_response.dart';

class Identity {
  String _sub;
  List<String> _sensors;
  List<String> _roles;
  List<String> _scope;
  String _username;
  DateTime _expiry;
  DateTime _issuedAt;
  
  Identity({
    String subject,
    List<String> sensors,
    List<String> roles,
    List<String> scope,
    String username,
    int expiry,
    int issuedAt
  }){
    _sub = subject;
    _sensors = sensors;
    _roles = roles;
    _scope = scope;
    _username = username;
    _expiry = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    _issuedAt = DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000);
  }


  /// Parse the [LoginResponse.access_token] into an [Identity].
  factory Identity.fromJWT(String accessToken){
    Map<String, dynamic> jwtParse = Jwt.parseJwt(accessToken);
    return Identity.fromJson(jwtParse);
  }

  factory Identity.fromJson(Map<String, dynamic> json){
    Iterable sensorsItr = json['sensors'];
    Iterable rolesItr = json['roles'];
    return Identity(
      subject: json['sub'],
      sensors: sensorsItr.toList().cast<String>(),
      roles: rolesItr.toList().cast<String>(),
      scope: json['scope'].split(' '),
      username: json['preferred_username'],
      expiry: json['exp'],
      issuedAt: json['iat']
    );
  }

  String get username => _username;
  DateTime get expiry => _expiry;
}