
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/domain/models/requests/create_event_data.dart';
import 'package:take_a_walk_app/domain/models/requests/event_edit_request.dart';
import 'package:take_a_walk_app/domain/models/requests/filter_data.dart';
import 'package:take_a_walk_app/domain/models/requests/live_location_request.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

abstract class EventsRepository {

  Future<Either<RequestError, int>> createEvent(CreateEventData createEventData);

  Future<Either<RequestError, List<EventObject>>> getUserEvents();

  Future<Either<RequestError, List<EventObject>>> getUserInvitations();

  Future<Either<RequestError, int>> acceptInvite(int eventId);

  Future<Either<RequestError, int>> declineInvite(int eventId);

  Future<Either<RequestError, List<EventObject>>> filterEvents(FilterData filter);

  Future<Either<RequestError, List<EventObject>>> filterInvitations(FilterData filter);

  Future<Either<RequestError, List<MapEventObj>>> getMapEvents();

  Future<Either<RequestError, EventDataResponse>> getEventDetail(int eventId);

  Future<Either<RequestError, List<EventPersonResponse>>> getEventPeople(int eventId);

  Future<Either<RequestError, List<PictureResponse>>> getEventPictures(int eventId);

  Future<RequestError?> postEventImage(int eventId, File file);

  Future<RequestError?> cancelEvent(int eventId);

  Future<RequestError?> nextLocation(int eventId);

  Future<RequestError?> updateLiveLocation(int eventId, LiveLocationRequest data);

  Future<RequestError?> updateEvent(int eventId, EventEditRequest request);
}