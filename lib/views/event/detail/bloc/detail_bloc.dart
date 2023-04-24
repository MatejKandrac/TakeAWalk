

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/models/responses/event_detail_response.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';

part 'detail_state.dart';

class EventDetailBloc extends Cubit<DetailState> {

  EventDetailBloc() : super(const DetailLoadingState());

  getDetail(int eventId) async {
    emit(const DetailLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    emit(const DetailDataState(
        eventName: "Rozbijacka",
        people: [
          EventInvite(name: "Kenjo", profileImage: null, inviteStatus: "PENDING")
        ],
        locations: [
          Location(
              lat: 48.148598,
              lon: 17.107748,
              name: "Bratislava"
          ),
          Location(
              lat: 48.148598,
              lon: 17.106748,
              name: "Bratislava Druha strana"
          ),
        ],
        dateText: "5.12.2001 - 5.12.2001",
        timeText: "13:00 - 15:00",
      deletable: true,
      editable: true,
      isInvite: true,
      isCancellable: true,
      ownerName: "Matej Kandrac",
      actualIndex: 1
    )
    );
  }

}