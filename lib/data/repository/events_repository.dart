import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/event/events_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/create_event_data.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

import '../../domain/models/requests/filter_data.dart';

class EventsRepositoryImpl extends BaseApiRepository implements EventsRepository {
  final AuthRepository authRepository;
  final EventsApiService eventsApiService;

  const EventsRepositoryImpl({required this.eventsApiService, required this.authRepository});

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
    var result = await makeRequest(request: () => eventsApiService.getUserEvents(id));
    // return await makeRequest<List<EventObject>>(request: () => eventsApiService.getUserEvents(id));
    return result;
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
  Future<Either<RequestError, List<EventObject>>> filterEvents (FilterData filter) async {
    int? id = await authRepository.getUserId();
    if (id == null) {
      return Left(RequestError.unauthenticated());
    }

    var result = await makeRequest(request: () => eventsApiService.filterEvents(id, filter));
    return result;
  }

  @override
  Future<Either<RequestError, List<EventObject>>> filterInvitations (FilterData filter) async {
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

}
