
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/network_image_mixin.dart';

part 'pick_person_state.dart';

class PickPersonBloc extends Cubit<PickPersonState> with NetworkImageMixin {

  final UsersRepository _repository;
  final Dio _dio;

  PickPersonBloc(this._repository, this._dio) : super(const PickPersonListState());
  Timer? taskTimer;

  postFetch(String text) {
    if (text.isNotEmpty) {
      emit(const PickPersonLoadingState());
      taskTimer?.cancel();
      taskTimer = Timer(const Duration(milliseconds: 500), () => _fetchPeople(text));
    }
  }

  _fetchPeople(String text) async {
    _repository.search(text).fold(
      (left) => emit(PickPersonErrorState(left.errorText)),
      (right) => emit(PickPersonListState(right)),
    );
  }

  selectPerson(SearchPersonResponse person) {
    emit(PickPersonListState(
      (state as PickPersonListState).people,
      person
    ));
  }

  Map<String, String> getHeaders() => getImageHeaders(_dio);

}