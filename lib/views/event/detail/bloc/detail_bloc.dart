

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/repositories/auth_repository.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/network_image_mixin.dart';

part 'detail_state.dart';

class EventDetailBloc extends Cubit<DetailState> with NetworkImageMixin {

  final Dio dio;
  final EventsRepository repository;
  final AuthRepository authRepository;
  final BehaviorSubject<List<EventPersonResponse>?> _peopleController = BehaviorSubject();
  final BehaviorSubject<List<String>> _picturesController = BehaviorSubject();
  final BehaviorSubject<bool> _pictureDialog = BehaviorSubject();

  late int eventId;
  get peopleStream => _peopleController.stream;
  get picturesStream => _picturesController.stream;
  get pictureDialogStream => _picturesController.stream;

  EventDetailBloc({
    required this.dio,
    required this.repository,
    required this.authRepository
  }) : super(const DetailLoadingState());

  getDetail(int eventId) async {
    this.eventId = eventId;
    emit(const DetailLoadingState());
    repository.getEventDetail(eventId).fold(
      (left) => emit(DetailErrorState(left.errorText)),
      (right) async {
        var dateText = "${AppConstants.dateFormat.format(right.eventTime.start!)} - "
            "${AppConstants.dateFormat.format(right.eventTime.end!)}";
        var timeText = "${AppConstants.timeFormat.format(right.eventTime.start!)} - "
            "${AppConstants.timeFormat.format(right.eventTime.end!)}";
        var currentId = await authRepository.getUserId();

        var isActive = DateTime.now().isAfter(right.eventTime.start!) && DateTime.now().isBefore(right.eventTime.end!);
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
            active: isActive
        ));
        repository.getEventPeople(eventId).fold(
                (left) => _peopleController.addError(left),
                (right) => _peopleController.sink.add(right)
        );
        repository.getEventPictures(eventId).fold(
                (left) => _picturesController.addError(left),
                (right) => _picturesController.sink.add(right)
        );
      },
    );
  }

  Map<String, String> getHeaders() => getImageHeaders(dio);

  addImage(bool isFromGallery) async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      _pictureDialog.sink.add(true);
      await repository.postEventImage(eventId, File(file.path)).then(
              (value) {
                if (value == null) {
                  repository.getEventPictures(eventId).fold(
                          (left) => _picturesController.addError(left),
                          (right) => _picturesController.sink.add(right)
                  );
                }
              });
      _pictureDialog.sink.add(false);
    }
  }

}