import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

import '../../domain/models/requests/filter_data.dart';
import '../../domain/models/responses/event_response.dart';
import '../../domain/models/responses/profile_response.dart';
import '../../widget/event_item.dart';

@RoutePage()
class MyEventsPage extends HookWidget {
  MyEventsPage({Key? key}) : super(key: key);

  // List<EventResponse> events = [
  //   EventResponse(
  //       id: 0,
  //       name: "Rozbijacka",
  //       status: Status.ACCEPTED,
  //       owner: ProfileResponse(username: "Matej", email: ""),
  //       dateStart: DateTime(2023, 1, 1),
  //       dateEnd: DateTime(2023, 12, 5),
  //       locations: [
  //         Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"),
  //         Location(lat: 48.148598, lon: 17.107748, name: "Co ja viem")
  //       ],
  //       profiles: [
  //         ProfileResponse(username: "Matejko", email: "")
  //       ]),
  //   EventResponse(
  //       id: 1,
  //       name: "TestEvent",
  //       owner: ProfileResponse(username: "Matej", email: ""),
  //       dateStart: DateTime(2023, 12, 4),
  //       dateEnd: DateTime(2023, 12, 5),
  //       status: Status.ACCEPTED,
  //       locations: [
  //         Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"),
  //         Location(lat: 48.148598, lon: 17.107748, name: "Co ja viem")
  //       ],
  //       profiles: [
  //         ProfileResponse(username: "Matejko", email: "")
  //       ]),
  // ];

  _onOpenFilter(BuildContext context) {
    // BlocProvider.of<MyEventsBloc>(context).getEventsData();
    AutoRouter.of(context).push(FilterRoute()).then((value) => {
          BlocProvider.of<MyEventsBloc>(context).filterEvents(value as FilterData?),
        });
  }

  _getFilterEventData(BuildContext context, List<EventObject> events) {
    BlocProvider.of<MyEventsBloc>(context).emitDataState(events);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<MyEventsBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.getEventsData();
      return null;
    }, const []);
    return BlocListener<MyEventsBloc, MyEventsState>(
      listener: (context, state) {
        if (state is FilteredDataState) {
          _getFilterEventData(context, state.events);
        }
      },
      child: BlocBuilder<MyEventsBloc, MyEventsState>(
        buildWhen: (previous, current) => current is EventsDataState,
        builder: (context, state) {
          return AppScaffold(
            appBar: AppBar(
              title: Text("My events", style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                IconButton(onPressed: () => _onOpenFilter(context), icon: const Icon(Icons.filter_alt_rounded)),
                const SizedBox(width: 10),
              ],
            ),
            navigationIndex: 0,
            fab: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => AutoRouter.of(context).push(const CreateEventRoute()),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: (state).events.length,
                itemBuilder: (context, index) => EventItem(
                  // event: events[index],
                  event: EventObject(
                    name: state.events[index].name,
                    owner: state.events[index].owner,
                    start: state.events[index].start,
                    end: state.events[index].end,
                    places: state.events[index].places,
                    peopleGoing: state.events[index].peopleGoing,
                    eventId: state.events[index].eventId

                    // id: (state).events[index].eventId,
                    // name: (state).events[index].name,
                    // // owner: ProfileResponse(username: (state).events[index].owner, email: ''),
                    // owner: (state).events[index].owner,
                    // dateStart: (state).events[index].start ?? DateTime(23, 12, 12),
                    // dateEnd: (state).events[index].end ?? DateTime(23, 12, 12),
                    // status: Status.ACCEPTED,
                    // locations: [],
                    // profiles: [],
                  ),
                  status: Status.ACCEPTED,
                  // onTap: () => {debugPrint(state.events.length.toString())},
                  onTap: () => {AutoRouter.of(context).push(EventDetailRoute(eventId: state.events[index].eventId))},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
