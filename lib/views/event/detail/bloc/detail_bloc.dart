import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/live_location_request.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/location_getter_mixin.dart';
import 'package:take_a_walk_app/utils/network_image_mixin.dart';
import 'package:take_a_walk_app/views/event/edit/event_edit_view.dart';

part 'detail_state.dart';

class EventDetailBloc extends Cubit<DetailState>
    with NetworkImageMixin, LocationMixin {
  final Dio dio;
  final EventsRepository repository;
  final AuthRepository authRepository;
  final BehaviorSubject<List<EventPersonResponse>?> _peopleController = BehaviorSubject();
  final BehaviorSubject<List<PictureResponse>> _picturesController = BehaviorSubject();
  final BehaviorSubject<bool> _loadingDialogController = BehaviorSubject();
  final BehaviorSubject<Position?> _positionStreamController = BehaviorSubject();
  final BehaviorSubject<String?> _errorController = BehaviorSubject();

  late DetailDataState dataState;

  bool activeLocation = false;
  late int eventId;

  get peopleStream => _peopleController.stream;

  get picturesStream => _picturesController.stream;

  Stream<bool> get loadingDialog => _loadingDialogController.stream;

  Stream<Position?> get positionStream => _positionStreamController.stream;

  Stream<String?> get errorStream => _errorController.stream;

  EventDetailBloc(
      {required this.dio,
      required this.repository,
      required this.authRepository})
      : super(const DetailLoadingState());

  getDetail(int eventId) async {
    emit(const DetailLoadingState());
    this.eventId = eventId;
    repository.getEventDetail(eventId).fold(
      (left) => emit(DetailErrorState(left.errorText)),
      (right) async {
        var dateText =
            "${AppConstants.dateFormat.format(right.eventTime.start!)} - "
            "${AppConstants.dateFormat.format(right.eventTime.end!)}";
        var timeText =
            "${AppConstants.timeFormat.format(right.eventTime.start!)} - "
            "${AppConstants.timeFormat.format(right.eventTime.end!)}";
        var currentId = await authRepository.getUserId();
        var isActive = DateTime.now().isAfter(right.eventTime.start!) &&
            DateTime.now().isBefore(right.eventTime.end!);
        emit(DetailDataState(
            eventName: right.eventName,
            dateText: dateText,
            timeText: timeText,
            ownerName: right.eventHost,
            locations: right.eventLocations,
            deletable: right.ownerId == currentId,
            editable: right.ownerId == currentId,
            isInvite: right.eventStatus == "PENDING" && !isActive,
            isCancellable: right.eventStatus == "ACCEPTED" && !isActive,
            actualIndex: right.currentIndex,
            locationLive: right.ownerId == currentId ? false : null,
            canGoNext: right.ownerId == currentId && isActive,
            active: isActive));
        dataState = state as DetailDataState;
        repository.getEventPeople(eventId).fold(
            (left) => _peopleController.addError(left),
            (right) => _peopleController.sink.add(right));
        repository.getEventPictures(eventId).fold(
            (left) => _picturesController.addError(left),
            (right) => _picturesController.sink.add(right));
        if (right.ownerLon != null && right.ownerLat != null) {
          _positionStreamController.sink.add(Position(
            latitude: right.ownerLat!,
            longitude: right.ownerLon!,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speedAccuracy: 1,
              speed: 1
          ));
        }
      },
    );
  }

  Map<String, String> getHeaders() => getImageHeaders(dio);

  addImage(bool isFromGallery) async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      _loadingDialogController.sink.add(true);
      await repository.postEventImage(eventId, File(file.path)).then((value) {
        if (value == null) {
          repository.getEventPictures(eventId).fold(
              (left) => _picturesController.addError(left),
              (right) => _picturesController.sink.add(right));
        } else {
          _errorController.sink.add(value.errorText);
        }
      });
      _loadingDialogController.sink.add(false);
    }
  }

  acceptEvent() async {
    _loadingDialogController.sink.add(true);
    await repository.acceptInvite(eventId).fold(
        (left) => emit(const DetailErrorState("Could not accept event")),
        (right) => emit(const DetailInviteAcceptedState()));
    _loadingDialogController.sink.add(false);
  }

  declineEvent() async {
    _loadingDialogController.sink.add(true);
    await repository.declineInvite(eventId).fold(
        (left) => emit(const DetailErrorState("Could not accept event")),
        (right) => emit(const DetailInviteDeclinedState()));
    _loadingDialogController.sink.add(false);
  }

  leaveEvent() async {
    _loadingDialogController.sink.add(true);
    await repository.declineInvite(eventId).fold(
        (left) => emit(const DetailErrorState("Could not cancel invitation")),
        (right) => emit(const DetailInviteCancelledState()));
    _loadingDialogController.sink.add(false);
  }

  deleteEvent() async {
    _loadingDialogController.sink.add(true);
    var result = await repository.cancelEvent(eventId);
    if (result != null) {
      emit(DetailErrorState(result.errorText));
    } else {
      emit(const DetailEventCancelled());
    }
    _loadingDialogController.sink.add(false);
  }
  
  markNextLocation() async {
    _loadingDialogController.sink.add(true);
    var result = await repository.nextLocation(eventId);
    if (result != null) {
      _errorController.sink.add(result.errorText);
    } else {
      emit(dataState.copyWith(actualIndex: dataState.actualIndex + 1));
    }
    _loadingDialogController.sink.add(false);
  }

  togglePositioning() async {
    activeLocation = !activeLocation;
    emit(dataState.copyWith(locationLive: activeLocation));
    if (activeLocation) {
      await handlePermission();
      getPositionStream().listen((event) {
        repository.updateLiveLocation(eventId, LiveLocationRequest(lat: event.latitude, lon: event.longitude));
        _positionStreamController.sink.add(event);
      });
    } else {
      getPositionStream().listen(null);
    }
  }

  stopPositioning() {
    getPositionStream().listen(null);
  }

  EditArguments editArgs() {
    var timeSplit = dataState.timeText.split(" - ");
    return EditArguments(
        eventId: eventId,
        isActive: dataState.active,
        initialDate: dataState.dateText,
        initialTimeFrom: timeSplit[0],
        initialTimeTo: timeSplit[1],
        locations: dataState.locations,
        people: _peopleController.value!,
        pictures: _picturesController.value
    );
  }
}
