import 'dart:async';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/local/event_local_service.dart';
import 'package:take_a_walk_app/data/datasource/remote/event/events_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/create_event_data.dart';
import 'package:take_a_walk_app/domain/models/requests/event_edit_request.dart';
import 'package:take_a_walk_app/domain/models/requests/live_location_request.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../../domain/models/requests/filter_data.dart';

class EventsRepositoryImpl extends BaseApiRepository implements EventsRepository {
  final AuthRepository authRepository;
  final EventsApiService eventsApiService;
  final EventLocalService eventLocalService;

  const EventsRepositoryImpl(
      {required this.eventsApiService, required this.authRepository, required this.eventLocalService});

  @override
  Future<Either<RequestError, int>> createEvent(CreateEventData createEventData) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }
    createEventData.ownerId = id;
    var result = await makeRequest(request: () => eventsApiService.createEvent(createEventData));
    return result;
  }

  @override
  Future<Either<RequestError, List<EventObject>>> getUserEvents() async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }
    var response = await makeRequest(
        request: () => eventsApiService.getUserEvents(id),
        localRequest: () => eventLocalService.getAllUserEvents(false));

    if (response.isRight) {
      print('It is right');
      for (EventObject event in response.right) {
        var isPresent = await eventLocalService.isPresent(event.eventId);
        if (isPresent) {
          print('Updating event');
          print(event.end);
          eventLocalService.updateEvent(event);
        } else {
          print('Saving event');
          eventLocalService.saveEvent(event);
        }
      }
    }

    return response;
  }

  @override
  Future<Either<RequestError, List<EventObject>>> getUserInvitations() async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }
    var result = await makeRequest(request: () => eventsApiService.getUserInvitations(id));
    // return await makeRequest<List<EventObject>>(request: () => eventsApiService.getUserEvents(id));
    return result;
  }

  @override
  Future<Either<RequestError, int>> acceptInvite(int eventId) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var result = await makeRequest(request: () => eventsApiService.acceptInvite(eventId, id));
    return result;
  }

  @override
  Future<Either<RequestError, int>> declineInvite(int eventId) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var result = await makeRequest(request: () => eventsApiService.declineInvite(eventId, id));
    return result;
  }

  @override
  Future<Either<RequestError, List<EventObject>>> filterEvents(FilterData filter) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var result = await makeRequest(
        request: () => eventsApiService.filterEvents(id, filter),
        localRequest: () => eventLocalService.filterUserEvents(id, filter)
    );
    return result;
  }

  @override
  Future<Either<RequestError, List<EventObject>>> filterInvitations(FilterData filter) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var result = await makeRequest(request: () => eventsApiService.filterInvitations(id, filter));
    return result;
  }

  @override
  Future<Either<RequestError, List<MapEventObj>>> getMapEvents() async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    int limit = 5;
    var result = await makeRequest(request: () => eventsApiService.getMapEvents(id, limit));
    return result;
  }

  @override
  Future<Either<RequestError, EventDataResponse>> getEventDetail(int eventId) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }
    return makeRequest(request: () => eventsApiService.getEventData(eventId, id));
  }

  @override
  Future<Either<RequestError, List<EventPersonResponse>>> getEventPeople(int eventId) {
    return makeRequest(request: () => eventsApiService.getEventPeople(eventId, true));
  }

  @override
  Future<Either<RequestError, List<PictureResponse>>> getEventPictures(int eventId) {
    return makeRequest(request: () => eventsApiService.getEventPictures(eventId));
  }

  @override
  Future<RequestError?> postEventImage(int eventId, File file) {
    return makeRequest(request: () => eventsApiService.postEventImage(eventId, file)).fold(
            (left) => left,
            (right) => null
    );
  }

  @override
  Future<RequestError?> cancelEvent(int eventId) {
    return makeRequest(request: () => eventsApiService.cancelEvent(eventId)).fold(
            (left) => left,
            (right) => null
    );
  }

  @override
  Future<RequestError?> nextLocation(int eventId) {
    return makeRequest(request: () => eventsApiService.nextLocation(eventId)).fold(
            (left) => left,
            (right) => null
    );
  }

  @override
  Future<RequestError?> updateLiveLocation(int eventId, LiveLocationRequest data) {
    return makeRequest(request: () => eventsApiService.updateLiveLocation(eventId, data)).fold(
            (left) => left,
            (right) => null
    );
  }

  @override
  Future<RequestError?> updateEvent(int eventId, EventEditRequest request) {
    return makeRequest(request: () => eventsApiService.updateEvent(eventId, request)).fold(
            (left) => left,
            (right) => null
    );
  }

}
