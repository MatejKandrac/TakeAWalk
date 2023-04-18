
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'pick_person_state.dart';

class PickPersonBloc extends Cubit<PickPersonState> {

  final UsersRepository _repository;

  PickPersonBloc(this._repository) : super(const PickPersonListState());
  Timer? taskTimer;

  getPeople(String searchText) {

  }

  postFetch(String text) {
    emit(const PickPersonLoadingState());
    taskTimer?.cancel();
    taskTimer = Timer(const Duration(milliseconds: 500), () => _fetchPeople(text));
  }

  _fetchPeople(String text) async {
    print(text);
  }

}