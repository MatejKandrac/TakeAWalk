
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:take_a_walk_app/utils/request_error.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:retrofit/dio.dart';

abstract class BaseApiRepository {

  const BaseApiRepository();
  
  Future<Either<RequestError, T>> makeRequest<T>({
    required Future<HttpResponse<T>> Function() request
  }) async {
    try {
      final response = await request();
      print(response.response.statusCode);
      if (response.response.statusCode == HttpStatus.ok) {
        return Right(response.data);
      } else {
        return Left(response.response.statusCode.toRequestError());
      }
    } on DioError catch (e) {
      print(e);
      print(e.response?.statusCode);
      if (e.response == null) {
        return Left(RequestError.noInternet());
      }
      return Left(e.response?.statusCode.toRequestError() ?? RequestError.unknown());
    }
  }
}