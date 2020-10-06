import 'package:dio/dio.dart';
import 'package:lorapark_app/config/urls.dart';

class LoraParkOptions extends BaseOptions {
  @override
  // TODO: implement baseUrl
  String get baseUrl => apiUrls['baseUrl'];
}