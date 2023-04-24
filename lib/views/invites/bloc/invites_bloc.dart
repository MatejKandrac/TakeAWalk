import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/events_repository.dart';

import '../../../domain/models/requests/filter_data.dart';
import '../../../domain/models/responses/event_response.dart';

part 'invites_states.dart';

class InvitesBloc extends Cubit<InvitesState> {
  final EventsRepository repository;

  InvitesBloc(this.repository) : super(InvitesDataState.empty());

  void getInvitesData() async {
    repository.getUserInvitations().fold((error) => () {}, (data) async {
      emit(InvitesDataState(data));
      print(data);
    });
  }

  void acceptInvite(int eventId) async {
    repository.acceptInvite(eventId);
  }

  void declineInvite(int eventId) async {
    repository.acceptInvite(eventId);
  }

  void filterInvites(FilterData? filterData) async {
    if (filterData == null) return;

    repository
        .filterInvitations(filterData).fold(
            (error) => () {},
            (data) async {emit(FilteredInviteDataState(data));}
    );
  }

  void emitDataState(List<EventObject> events) async {
    emit(InvitesDataState(events));
  }

}
