
import 'package:either_dart/src/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/chat/chats_api_service.dart';
import 'package:take_a_walk_app/domain/models/requests/message_data_request.dart';
import 'package:take_a_walk_app/domain/models/responses/chat_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/chats_repository.dart';
import 'base_repository.dart';

class ChatsRepositoryImpl extends BaseApiRepository implements ChatsRepository {
  final AuthRepository authRepository;
  final ChatsApiService chatsApiService;

  const ChatsRepositoryImpl({required this.authRepository, required this.chatsApiService});

  @override
  Future<Either<RequestError, List<MessageObj>>> getEventMessages(int eventId, int pageNumber) async {
    int pageSize = 3;

    var result = await makeRequest(request: () => chatsApiService.getEventMessages(eventId, pageNumber, pageSize));
    return result;
  }

  @override
  Future<Either<RequestError, int>> postEventMessage(int eventId, String message) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var messageData = MessageData(message: message, userId: id);

    var result = await makeRequest(request: () => chatsApiService.postEventMessage(eventId, messageData));
    return result;
  }

}
