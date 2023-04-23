import 'dart:core';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/models/requests/create_event_data.dart';
import '../../../../domain/models/requests/filter_data.dart';
import '../../../../domain/models/responses/event_response.dart';

part 'events_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class EventsApiService {
  factory EventsApiService(Dio dio, {String baseUrl}) = _EventsApiService;

  // Invitations and Event

  @GET('/v1/events/{user-id}/invitations')
  Future<HttpResponse<List<EventObject>>> getUserInvitations(@Path('user-id') int userId);

  @GET('/v1/events/{user-id}/my-events')
  Future<HttpResponse<List<EventObject>>> getUserEvents(@Path('user-id') int userId);
  
  // Accept & Decline
  
  @PUT('/v1/events/{event-id}/accept')
  Future<HttpResponse<int>> acceptInvite(@Path('event-id') int eventId, @Query('user-id') int? userId);

  @PUT('/v1/events/{event-id}/decline')
  Future<HttpResponse<int>> declineInvite(@Path('event-id') int eventId, @Query('user-id') int? userId);


  // Filter
  @GET('/v1/events/{user-id}/my-events/filter')
  Future<HttpResponse<List<EventObject>>> filterEvents(@Path('user-id') int userId, @Body() FilterData filter);

  @GET('/v1/events/{user-id}/invitations/filter')
  Future<HttpResponse<List<EventObject>>> filterInvitations(@Path('user-id') int userId, @Body() FilterData filter);


  @GET('/v1/event/{event-id}/host')
  Future<HttpResponse<String?>> getEventOwner(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/people')
  Future<HttpResponse<List<String>>?> getEventPeople(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/description')
  Future<HttpResponse<String>?> getEventDescription(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/status')
  Future<HttpResponse<String>?> getEventStatus(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/data')
  Future<HttpResponse<EventData>> getEventData(@Path('event-id') int eventId);

  // Event Progress

  @DELETE('/v1/event/{event-id}/picture')
  Future<HttpResponse<String>> deleteEventPicture(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @PUT('/v1/event/{event-id}/description')
  Future<HttpResponse<String>> updateEventDescription(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @PUT('/v1/event/{event-id}/location-status')
  Future<HttpResponse<String>> updateLocationStatus(@Path('event-id') int eventId, @Body() Map<String, dynamic> data);

  @POST('/v1/event')
  Future<HttpResponse<int>> createEvent(@Body() CreateEventData data);

  @GET('/v1/events/{user-id}/map/my-events')
  Future<HttpResponse<List<MapEventObj>>> getMapEvents(@Path('user-id') int userId, @Query('limit') int? limit);
}
