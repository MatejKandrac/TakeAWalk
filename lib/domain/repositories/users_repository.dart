import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class UsersRepository {

  Future<Either<RequestError, ProfileResponse>> getProfile(int id);

}