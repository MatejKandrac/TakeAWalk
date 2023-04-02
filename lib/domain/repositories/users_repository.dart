import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/requests/login_request.dart';
import 'package:take_a_walk_app/domain/models/responses/auth_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class UsersRepository {

  Future<Either<RequestError, AuthResponse>> logIn(LoginRequest request);

}