import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/models/requests/create_event_data.dart';
import '../../../../domain/models/responses/event_response.dart';

part 'events_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class EventsApiService {
  factory EventsApiService(Dio dio, {String baseUrl}) = _EventsApiService;

  // Invitations and Event

  @GET('/v1/events/{user-id}/invitations')
  Future<List<EventObject>>? getUserInvitations(@Path('user-id') int userId);

  @GET('/v1/events/{user-id}/my-events')
  Future<List<EventObject>>? getUserEvents(@Path('user_id') int userId);

  @GET('/v1/event/{event-id}/host')
  Future<String?> getEventOwner(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/people')
  Future<List<String>>? getEventPeople(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/description')
  Future<String>? getEventDescription(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/status')
  Future<String>? getEventStatus(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/data')
  Future<EventData> getEventData(@Path('event-id') int eventId);

  // Event Progress

  @DELETE('/v1/event/{event-id}/picture')
  Future<HttpResponse<String>> deleteEventPicture(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @PUT('/v1/event/{event-id}/description')
  Future<HttpResponse<String>> updateEventDescription(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @PUT('/v1/event/{event-id}/location-status')
  Future<HttpResponse<String>> updateLocationStatus(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @POST('/v1/event')
  Future<int>? createEvent(@Body() CreateEventData data);
  
  @GET('/v1/events/{user-id}/map/my-events')
  Future<List<MapEventObj>>? getMapEvents(@Path('user-id') int userId, @Query('limit') int? limit);
  
}
