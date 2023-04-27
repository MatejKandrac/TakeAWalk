
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/responses/chat_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class ChatsRepository {

  Future<Either<RequestError, List<MessageObj>>> getEventMessages(int eventId, int pageNumber);

  Future<Either<RequestError, int>> postEventMessage(int eventId, String message);

}