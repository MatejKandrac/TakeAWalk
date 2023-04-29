import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/event_item.dart';

import '../../domain/models/requests/filter_data.dart';
import 'bloc/invites_bloc.dart';

@RoutePage()
class InvitesPage extends HookWidget {
  const InvitesPage({Key? key}) : super(key: key);

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

  _onDetail(BuildContext context, int eventId) {
    AutoRouter.of(context).push(EventDetailRoute(eventId: eventId));
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
                itemCount: (state).events.length,
                itemBuilder: (context, index) => EventItem(
                  event: state.events[index],
                  status: Status.PENDING,
                  onTap: () => _onDetail(context, state.events[index].eventId),
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
