import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/event_item.dart';

import '../../domain/models/requests/filter_data.dart';

@RoutePage()
class InvitesPage extends HookWidget {
  InvitesPage({Key? key}) : super(key: key);

  _onOpenFilter(BuildContext context) {
    AutoRouter.of(context).push(const FilterRoute()).then((value) => {
      BlocProvider.of<InvitesBloc>(context).filterInvites(value as FilterData?),
    });
  }

  _getFilterData(BuildContext context, List<EventObject> events) {
    BlocProvider.of<InvitesBloc>(context).emitDataState(events);
  }

  _onAccept(BuildContext context, int eventId) {
    BlocProvider.of<InvitesBloc>(context).acceptInvite(eventId);
  }

  _onDecline(BuildContext context, int eventId) {
    BlocProvider.of<InvitesBloc>(context).declineInvite(eventId);
  }

  List<EventResponse> events = [
    EventResponse(
        id: 0,
        name: "Rozbijacka",
        status: Status.PENDING,
        owner: ProfileResponse(username: "Matej", email: ""),
        // owner: "Patrik",
        dateStart: DateTime(2023, 1, 1),
        dateEnd: DateTime(2023, 12, 5),
        locations: [
          Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"),
          Location(lat: 48.148598, lon: 17.107748, name: "Co ja viem")
        ],
        profiles: [
          ProfileResponse(username: "Matejko", email: "")
        ]),
    EventResponse(
        id: 1,
        name: "TestTestTest123456",
        owner: ProfileResponse(username: "Tester", email: ""),
        dateStart: DateTime(2023, 12, 4),
        dateEnd: DateTime(2023, 12, 5),
        status: Status.ACCEPTED,
        locations: [
          Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"),
          Location(lat: 48.148598, lon: 17.107748, name: "Co ja viem")
        ],
        profiles: [
          ProfileResponse(username: "Matejko", email: "")
        ]),
  ];


  _onDetail(BuildContext context, int index) {
    AutoRouter.of(context).push(InviteDetailRoute(event: events[index]));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<InvitesBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.getInvitesData();
      return null;
    }, const []);
    return BlocListener<InvitesBloc, InvitesState>(
      listener: (context, state) {
        if (state is FilteredInviteDataState) {
          _getFilterData(context, state.events);
        }
      },
      child: BlocBuilder<InvitesBloc, InvitesState>(
        buildWhen: (previous, current) => current is InvitesDataState,
        builder: (context, state) {
          return AppScaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Invites", style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                IconButton(onPressed: () => _onOpenFilter(context), icon: const Icon(Icons.filter_alt_rounded)),
                const SizedBox(width: 10),
              ],
            ),
            navigationIndex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                // itemCount: events.length,
                itemCount: (state).events.length,
                itemBuilder: (context, index) => EventItem(
                  // event: events[index],
                  event: EventObject(
                    eventId: state.events[index].eventId,
                    name: state.events[index].name,
                    owner: state.events[index].owner,
                    start: state.events[index].start,
                    end: state.events[index].end,
                    places: state.events[index].places,
                    peopleGoing: state.events[index].peopleGoing,


                    // id: state.events[index].eventId,
                    // name: state.events[index].name,
                    // // owner: ProfileResponse(username: state.events[index].owner, email: ''),
                    // owner: state.events[index].owner,
                    // dateStart: DateTime(2023, 12, 12),
                    // dateEnd: DateTime(2023, 12, 12),
                    // status: Status.PENDING,
                    // locations: [],
                    // profiles: [],
                  ),
                  status: Status.PENDING,
                  onTap: () => _onDetail(context, index),
                  onDecline: () => _onDecline(context, state.events[index].eventId),
                  onAccept: () => _onAccept(context, state.events[index].eventId),
                  // onAccept: () => print(state.events[index].eventId),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
