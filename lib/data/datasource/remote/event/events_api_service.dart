import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_a_walk_app/domain/models/requests/event_edit_request.dart';
import 'package:take_a_walk_app/domain/models/requests/live_location_request.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';

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
  Future<HttpResponse<List<EventPersonResponse>>> getEventPeople(@Path('event-id') int eventId, @Query('include-pending') bool includePending);

  @GET('/v1/event/{event-id}/description')
  Future<HttpResponse<String>?> getEventDescription(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/status')
  Future<HttpResponse<String>?> getEventStatus(@Path('event-id') int eventId);

  @GET('/v1/event/{event-id}/data')
  Future<HttpResponse<EventDataResponse>> getEventData(@Path('event-id') int eventId, @Query('user-id') int userId);

  // Event Progress

  @GET('/v1/event/{event-id}/pictures')
  Future<HttpResponse<List<PictureResponse>>> getEventPictures(@Path('event-id') int eventId);

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

  @POST('/v1/event/{event-id}/picture')
  @MultiPart()
  Future<HttpResponse<String>> postEventImage(@Path('event-id') int eventId, @Part(name: 'file') File file);

  @PUT('/v1/event/{event-id}/next-location')
  Future<HttpResponse<String?>> nextLocation(@Path('event-id') int eventId);

  @DELETE('/v1/event/{event-id}')
  Future<HttpResponse<int?>> cancelEvent(@Path('event-id') int eventId);

  @PUT('/v1/event/{event-id}/live-location')
  Future<HttpResponse<String>> updateLiveLocation(@Path('event-id') int eventId, @Body() LiveLocationRequest data);

  @PUT('/v1/event/{event-id}')
  Future<HttpResponse<String?>> updateEvent(@Path('event-id') int eventId, @Body() EventEditRequest data);

}
