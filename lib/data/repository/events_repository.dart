
import 'package:either_dart/either.dart';
import 'package:take_a_walk_app/data/datasource/remote/event/events_api_service.dart';
import 'package:take_a_walk_app/data/repository/base_repository.dart';
import 'package:take_a_walk_app/domain/models/requests/create_event_data.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/request_error.dart';

class EventsRepositoryImpl extends BaseApiRepository implements EventsRepository {

  final AuthRepository authRepository;
  final EventsApiService eventsApiService;

  const EventsRepositoryImpl({
    required this.eventsApiService,
    required this.authRepository
  });

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

}