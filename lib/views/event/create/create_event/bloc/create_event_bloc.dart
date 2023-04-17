
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';

part 'create_event_state.dart';

class CreateEventBloc extends Cubit<CreateEventState> {

  CreateEventBloc() : super(const CreateFormState());

  final List<Location> _locations = [];
  final List<ProfileResponse> _profiles = [];



}