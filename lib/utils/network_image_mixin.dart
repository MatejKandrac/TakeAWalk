

import 'package:dio/dio.dart';
import 'package:take_a_walk_app/config/constants.dart';

class NetworkImageMixin {

  getImageUrl(String path) => "${AppConstants.baseUrl}/v1/picture/$path";

  getImageHeaders(Dio dio) => <String, String>{
    "Authorization": dio.options.headers["Authorization"]
  };
}