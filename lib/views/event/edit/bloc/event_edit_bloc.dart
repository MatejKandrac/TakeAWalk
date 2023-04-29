
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/requests/event_edit_request.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';
import 'package:take_a_walk_app/utils/network_image_mixin.dart';
import 'package:take_a_walk_app/views/event/edit/event_edit_view.dart';

part 'event_edit_state.dart';

class EventEditBloc extends Cubit<EventEditState> with NetworkImageMixin {

  final BehaviorSubject<bool> _loadingDialogController = BehaviorSubject();
  
  final EventsRepository _repository;
  final Dio _dio;
  final List<Location> _locations = [];
  final List<EventPersonResponse> _people = [];
  final List<PictureResponse> _pictures = [];
  final List<int> _deletedImages = [];
  late EditArguments args;

  bool locationsEdited = false;
  bool peopleEdited = false;
  bool picturesEdited = false;

  EventEditBloc(this._repository, this._dio) : super(EventEditState.empty());

  Stream<bool> get loadingStream => _loadingDialogController.stream;

  void setData(EditArguments args) {
    this.args = args;
    if (args.pictures != null) {
      _pictures.addAll(args.pictures!.toList());
    }
    emit(EventEditState(locations: _locations, people: _people, pictures: _pictures));
  }

  addPerson(SearchPersonResponse value) {
    peopleEdited = true;
    _people.add(EventPersonResponse(status: "", username: value.username, picture: value.picture, id: value.id));
    emit(EventEditState(
        locations: _locations,
        people: _people,
        pictures: _pictures
    ));
  }

  void addLocation(Location value) {
    locationsEdited = true;
    _locations.add(value);
    emit(EventEditState(
        locations: _locations,
        people: _people,
        pictures: _pictures
    ));
  }

  void deleteLocation(Location location) {
    locationsEdited = true;
    _locations.remove(location);
    emit(EventEditState(
        locations: _locations,
        people: _people,
        pictures: _pictures
    ));
  }

  void onReorder(int oldIndex, int newIndex) {
    locationsEdited = true;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Location item = _locations.removeAt(oldIndex);
    _locations.insert(newIndex, item);
    emit(EventEditState(
        locations: _locations,
        people: _people,
        pictures: _pictures
    ));
  }

  Map<String, String> getHeaders() => getImageHeaders(_dio);

  void onSave(String dateRangeText, String timeStartText, String timeEndText) async {

    DateTime? dateStart;
    DateTime? dateEnd;

    if (dateRangeText != args.initialDate || timeStartText != args.initialTimeFrom || timeEndText != args.initialTimeTo) {
      String? dateError;
      String? timeStartError;
      String? timeEndError;
      DateTime? timeStart;
      DateTime? timeEnd;

      if (timeStartText.isEmpty) {
        timeStartError = "This field is required";
      } else {
        try {
          timeStart = AppConstants.timeFormat.parse(timeStartText);
        } catch (e) {
          timeStartError = "Invalid format";
        }
      }

      if (timeEndText.isEmpty) {
        timeEndError = "This field is required";
      } else {
        try {
          timeEnd = AppConstants.timeFormat.parse(timeEndText);
        } catch (e) {
          timeEndError = "Invalid format";
        }
      }

      if (dateRangeText.isEmpty) {
        dateError = "This field is required";
      } else {
        var split = dateRangeText.split(' - ');
        if (split.length != 2) {
          dateError = "Invalid format, use dd.MM.yyyy";
        } else {
          try {
            dateStart = AppConstants.dateFormat.parse(split[0]);
            dateEnd = AppConstants.dateFormat.parse(split[1]);
            if (timeStart != null && timeEnd != null) {
              dateStart = dateStart.copyWith(
                  hour: timeStart.hour,
                  minute: timeStart.minute
              );
              dateEnd = dateEnd.copyWith(
                  hour: timeEnd.hour,
                  minute: timeEnd.minute
              );
              if (dateEnd.isBefore(dateStart)) {
                dateError = "End is before start";
              }
            }
          } catch (e) {
            dateError = "Invalid format, use dd.MM.yyyy";
          }
        }
      }

      if (dateError != null || timeStartError != null || timeEndError != null) {
        print("had error");
        emit(EventEditState(
            locations: _locations,
            people: _people,
            pictures: _pictures,
            dateError: dateError,
            timeEndError: timeEndError,
            timeStartError: timeStartError
        ));
        return;
      }
    }

    _loadingDialogController.sink.add(true);

    final locations = <LocationNew>[];
    for (int i = 0; i < _locations.length; i++) {
      locations.add(LocationNew(
          name: _locations[i].name,
          lat: _locations[i].lat,
          lon: _locations[i].lon,
          order: i + args.locations.length
      ));
    }
    var request = EventEditRequest(
      end: dateEnd,
      start: dateStart,
      newPeople: _people.map((e) => e.id!).toList(),
      newLocations: locations,
      deletedPictures: _deletedImages
    );
    await _repository.updateEvent(args.eventId, request).then((value) {
      _loadingDialogController.sink.add(false);
      emit(EventEditState(locations: _locations, people: _people, pictures: _pictures, updateState: value == null));
    });
  }

  deletePerson(int index) {
    _people.removeAt(index);
    emit(EventEditState(locations: _locations, people: _people, pictures: _pictures));
  }

  deleteImage(int index) {
    _deletedImages.add(_pictures[index].id);
    _pictures.removeAt(index);
    emit(EventEditState(locations: _locations, people: _people, pictures: _pictures));
  }

}