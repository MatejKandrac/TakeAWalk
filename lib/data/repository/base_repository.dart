
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:retrofit/dio.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class BaseApiRepository {

  const BaseApiRepository(  );

  static const successStates = [
    HttpStatus.ok, HttpStatus.created, HttpStatus.accepted, HttpStatus.noContent
  ];

  Future<Either<RequestError, T>> makeRequest<T>({
    required Future<HttpResponse<T>> Function() request,
    Future<T> Function()? localRequest
  }) async {
    try {
      final response = await request();
      print(response.response.statusCode);
      if (successStates.contains(response.response.statusCode)) {
        return Right(response.data);
      } else {
        return Left(response.response.statusCode.toRequestError());
      }
    } on DioError catch (e, stacktrace) {
      print(e.response?.statusCode);
      print(e);
      print(stacktrace);
      if (e.response == null) {
        if (localRequest != null) {
          final localResponse = await localRequest();
          return Right(localResponse);
        }

        return Left(RequestError.noInternet());
      }
      return Left(e.response?.statusCode.toRequestError() ?? RequestError.unknown());
    }
  }
}