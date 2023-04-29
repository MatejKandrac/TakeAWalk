import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/views/bloc_container.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

import '../../domain/models/requests/filter_data.dart';
import '../../domain/models/responses/event_response.dart';
import '../../widget/event_item.dart';

@RoutePage()
class MyEventsPage extends HookWidget {
  MyEventsPage({Key? key}) : super(key: key);

  _onOpenFilter(BuildContext context) {
    AutoRouter.of(context).push(const FilterRoute()).then((value) => {
          BlocProvider.of<MyEventsBloc>(context).filterEvents(value as FilterData?),
        });
  }

  _getFilterEventData(BuildContext context, List<EventObject> events) {
    BlocProvider.of<MyEventsBloc>(context).emitDataState(events);
  }

  _onDetail(int eventId, BuildContext context) {
    AutoRouter.of(context).push(EventDetailRoute(eventId: eventId));
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
                  event: state.events[index],
                  status: Status.ACCEPTED,
                  onTap: () => _onDetail(state.events[index].eventId, context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
