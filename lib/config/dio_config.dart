import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lorapark_app/config/urls.dart';

class LoraParkOptions extends BaseOptions {
  @override
  String get baseUrl => apiUrls['baseUrl'];

  @override
  String get contentType => ContentType.json.toString();
}