import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureService{
  static SecureService _secureService;
  FlutterSecureStorage _flutterSecureStorage;
  FlutterSecureStorage get secureStorage => _flutterSecureStorage;

  factory SecureService(){
    return _secureService ??= SecureService._();
  }

  SecureService._(){
    _flutterSecureStorage = FlutterSecureStorage();
  }
}