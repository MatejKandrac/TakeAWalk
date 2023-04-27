
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/utils/request_error.dart';
import 'package:take_a_walk_app/utils/transform_locations_mixin.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/views/event/detail/widget/image_pick_choice.dart';
import 'package:take_a_walk_app/widget/location_widget.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/person_widget.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

import 'bloc/detail_bloc.dart';

@RoutePage()
class EventDetailPage extends HookWidget with TransformLocationsMixin {
  const EventDetailPage({Key? key, required this.eventId}) : super(key: key);
  final int eventId;

  _onDelete(BuildContext context) {

  }

  _onEdit(BuildContext context) {

  }

  _onDecline(BuildContext context) {

  }

  _onAccept(BuildContext context) {

  }

  _leaveEvent(BuildContext context) {

  }

  _onOpenChat(BuildContext context) {
    AutoRouter.of(context).push(ChatRoute(eventId: eventId));
  }

  _onAddImage(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => const ImagePickChoice())
    .then((value) {
      if (value != null) {
        BlocProvider.of<EventDetailBloc>(context).addImage(value);
      }
    });
  }

  Widget _loadingBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event detail", style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<EventDetailBloc>(() => di(), const []);
    useEffect(() {
      bloc.getDetail(eventId);
      return null;
    });
    return BlocProvider<EventDetailBloc>(
      create: (context) => bloc,
      child: BlocListener<EventDetailBloc, DetailState> (
        listener: (context, state) {
          if (state is DetailErrorState) {
            showStateDialog(
                context: context,
                isSuccess: false,
                closeOnConfirm: true,
                text: state.text
            ).then((value) => Navigator.of(context).pop());
          }
        },
        child: BlocBuilder<EventDetailBloc, DetailState> (
          buildWhen: (previous, current) => current is! DetailErrorState,
          builder: (context, state) {
            if (state is DetailLoadingState) return _loadingBody(context);
            (state as DetailDataState);
            var positions = toListLatLon(state.locations);
            return Scaffold(
              appBar: AppBar(
                title: Text(state.eventName, style: Theme.of(context).textTheme.bodyMedium),
                actions: [
                  if (state.deletable) IconButton(onPressed: () => _onDelete(context), icon: const Icon(Icons.delete)),
                  if (state.editable) IconButton(onPressed: () => _onEdit(context), icon: const Icon(Icons.edit)),
                ],
              ),
              floatingActionButton: state.active ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                      heroTag: "CHAT",
                      child: const Icon(Icons.chat),
                      onPressed: () => _onOpenChat(context)
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                      heroTag: "PHOTO",
                      child: const Icon(Icons.photo_camera),
                      onPressed: () => _onAddImage(context)
                  ),
                ],
              ) : null,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Host: ${state.ownerName}"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Color(0xff7740c2)),
                          const SizedBox(width: 10),
                          Text(state.dateText, style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.timelapse, color: Color(0xff7740c2)),
                          const SizedBox(width: 10),
                          Text(state.timeText, style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                      const SizedBox(height: 20),
                      MapWidget(
                        heroTag: -1,
                        bounds: LatLngBounds.fromPoints(positions),
                        layers: [
                          MarkerLayer(
                            markers: [
                              for (var location in state.locations)
                              Marker(
                                  point: toLatLon(location),
                                  builder: (context) => const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("Locations:", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 5),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.locations.length,
                        itemBuilder: (context, index) => LocationWidget(
                          textPrefix: "${index + 1}. ",
                          location: state.locations[index],
                          isReorder: false,
                          visited: index < state.actualIndex,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(height: 2, color: Colors.white),
                      const SizedBox(height: 10),
                      Text("People:", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 5),
                      StreamBuilder<List<EventPersonResponse>?>(
                        stream: bloc.peopleStream,
                        initialData: null,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Failed: ${(snapshot.error as RequestError).errorText}"),
                            );
                          }
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => PersonWidget(
                              name: snapshot.data![index].username,
                              picture: snapshot.data![index].picture,
                              suffix: Icon(snapshot.data![index].status.getInviteIcon()),
                              onImageUrl: bloc.getImageUrl,
                              onRequestHeaders: bloc.getHeaders,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                      const Divider(height: 2, color: Colors.white),
                      const SizedBox(height: 10),
                      StreamBuilder<List<String>?>(
                        initialData: null,
                        stream: bloc.picturesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Failed: ${(snapshot.error as RequestError).errorText}"),
                            );
                          }
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.data!.isNotEmpty) Text("Event images:", style: Theme.of(context).textTheme.bodyMedium),
                                if (snapshot.data!.isNotEmpty) const SizedBox(height: 5),
                                if (snapshot.data!.isNotEmpty) SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.network(
                                          bloc.getImageUrl(snapshot.data![index]),
                                          headers: bloc.getHeaders(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 5),
                      if (state.isInvite) Row(
                        children: [
                          Expanded(
                            child: AppButton.outlined(
                                outlineColor: const Color(0xffF20AB8),
                                onPressed: () => _onDecline(context),
                                child: Text("Decline", style: Theme.of(context).textTheme.bodySmall)
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AppButton.gradient(
                                onPressed: () => _onAccept(context),
                                child: Text("Accept", style: Theme.of(context).textTheme.bodySmall)
                            ),
                          ),
                        ],
                      ),
                      if (state.isCancellable) AppButton.gradient(
                          child: Text("Leave event", style: Theme.of(context).textTheme.bodySmall),
                          onPressed: () => _leaveEvent(context)
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}


extension IconForInviteState on String {

  IconData getInviteIcon() {
    switch (this) {
      case "ACCEPTED": return Icons.check;
      case "DECLINED": return Icons.close;
      default: return Icons.question_mark;
    }
  }
}