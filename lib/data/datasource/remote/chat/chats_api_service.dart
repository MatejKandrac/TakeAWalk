import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/config/constants.dart';

import '../../../../domain/models/requests/message_data_request.dart';
import '../../../../domain/models/responses/chat_response.dart';
part 'chats_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl, parser: Parser.MapSerializable)
abstract class ChatsApiService {
  factory ChatsApiService(Dio dio, {String baseUrl}) = _ChatsApiService;

  @GET('/chat/{event-id}/messages')
  Future<List<MessageObj>>? getEventMessages(@Path('event-id') int eventId);

  @POST('chat/{event-id}/message')
  Future<HttpResponse<String>> postEventMessage(
      @Path('event-id') int eventId, @Body() MessageData message);
}
