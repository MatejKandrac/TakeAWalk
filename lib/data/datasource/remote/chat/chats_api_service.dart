import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/models/requests/message_data_request.dart';
import '../../../../domain/models/responses/chat_response.dart';

part 'chats_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ChatsApiService {
  factory ChatsApiService(Dio dio, {String baseUrl}) = _ChatsApiService;

  @GET('/v1/chat/{event-id}/messages')
  Future<HttpResponse<List<MessageObj>>> getEventMessages(@Path('event-id') int eventId, @Query('page') int pageNumber, @Query('size') int pageSize);

  @POST('/v1/chat/{event-id}/message')
  Future<HttpResponse<int>> postEventMessage(
      @Path('event-id') int eventId, @Body() MessageData message);
}
