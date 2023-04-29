import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/event_person_response.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/picture_response.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/utils/transform_locations_mixin.dart';
import 'package:take_a_walk_app/views/event/edit/bloc/event_edit_bloc.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/location_widget.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/person_widget.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

@RoutePage()
class EventEditPage extends HookWidget with TransformLocationsMixin {
  const EventEditPage({required this.editArguments, Key? key})
      : super(key: key);

  final EditArguments editArguments;

  _onDatePick(BuildContext context, TextEditingController dateController) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    ).then((value) {
      if (value != null) {
        dateController.text =
            "${AppConstants.dateFormat.format(value.start)} - ${AppConstants.dateFormat.format(value.end)}";
      }
    });
  }

  _onTimePick(BuildContext context, TextEditingController timeController) {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()))
        .then((value) {
      if (value != null) {
        var dateTime =
            DateTime.now().copyWith(hour: value.hour, minute: value.minute);
        timeController.text = AppConstants.timeFormat.format(dateTime);
      }
    });
  }

  _onAddLocation(BuildContext context) {
    AutoRouter.of(context).push(const PickLocationRoute()).then((value) {
      if (value != null) {
        BlocProvider.of<EventEditBloc>(context).addLocation(value as Location);
      }
    });
  }

  _onPickPerson(BuildContext context) {
    AutoRouter.of(context).push(const PickPersonRoute()).then((value) {
      if (value != null) {
        BlocProvider.of<EventEditBloc>(context)
            .addPerson(value as SearchPersonResponse);
      }
    });
  }

  _onDeleteLocation(Location location, BuildContext context) {
    BlocProvider.of<EventEditBloc>(context).deleteLocation(location);
  }

  _onReorder(int oldIndex, int newIndex, BuildContext context) {
    BlocProvider.of<EventEditBloc>(context).onReorder(oldIndex, newIndex);
  }

  _onSave(
      EventEditBloc bloc, String dateRange, String timeStart, String timeEnd) {
    bloc.onSave(dateRange, timeStart, timeEnd);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<EventEditBloc>(() => di(), const []);
    final dateController = useTextEditingController();
    final timeStartController = useTextEditingController();
    final timeEndController = useTextEditingController();

    useEffect(() {
      bloc.setData(editArguments);
      dateController.text = editArguments.initialDate;
      timeStartController.text = editArguments.initialTimeFrom;
      timeEndController.text = editArguments.initialTimeTo;
      bloc.loadingStream.listen((event) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (event) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) =>
                    const LoadingDialog(loadingText: "Updating..."));
          } else {
            Navigator.of(context).pop();
          }
        });
      });
      return () => bloc.loadingStream.listen(null);
    });
    return BlocProvider<EventEditBloc>(
      create: (context) => bloc,
      child: BlocBuilder<EventEditBloc, EventEditState>(
        builder: (context, state) {
          if (state.updateState != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (state.updateState!) {
                showStateDialog(context: context, isSuccess: true, text: "Event updated")
                    .then((value) => Navigator.of(context).pop(true));
              } else {
                showStateDialog(context: context, isSuccess: false, text: "Could not update event", closeOnConfirm: true);
              }
            });
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Edit event",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (editArguments.isActive)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Color(0xff7740c2)),
                              const SizedBox(width: 10),
                              Text(editArguments.initialDate,
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.timelapse,
                                  color: Color(0xff7740c2)),
                              const SizedBox(width: 10),
                              Text(
                                  "${editArguments.initialTimeFrom} - ${editArguments.initialTimeTo}",
                                  style: Theme.of(context).textTheme.bodySmall)
                            ],
                          ),
                        ],
                      )
                    else
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: dateController,
                            labelText: "Date range",
                            inputType: TextInputType.datetime,
                            errorText: state.dateError,
                            icon: InkWell(
                              onTap: () => _onDatePick(context, dateController),
                              child: const Icon(Icons.calendar_today),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: timeStartController,
                                  labelText: "From",
                                  errorText: state.timeStartError,
                                  icon: InkWell(
                                    onTap: () => _onTimePick(
                                        context, timeStartController),
                                    child:
                                        const Icon(Icons.access_time_outlined),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AppTextField(
                                  controller: timeEndController,
                                  labelText: "To",
                                  errorText: state.timeEndError,
                                  icon: InkWell(
                                    onTap: () =>
                                        _onTimePick(context, timeEndController),
                                    child:
                                        const Icon(Icons.access_time_outlined),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    MapWidget(
                        heroTag: -1,
                        layers: [
                          if (editArguments.locations.isNotEmpty)
                            MarkerLayer(
                              markers: [
                                for (var position
                                    in toListLatLon(editArguments.locations))
                                  Marker(
                                      anchorPos:
                                          AnchorPos.align(AnchorAlign.top),
                                      point: position,
                                      builder: (context) => const Icon(
                                          Icons.location_on,
                                          color: Colors.red)
                                  ),
                                for (var position in toListLatLon(state.locations))
                                  Marker(
                                      anchorPos:
                                      AnchorPos.align(AnchorAlign.top),
                                      point: position,
                                      builder: (context) => const Icon(
                                          Icons.add_location_alt,
                                          color: Colors.red)
                                  ),
                              ],
                            )
                        ],
                        bounds: editArguments.locations.isNotEmpty
                            ? LatLngBounds.fromPoints(toListLatLon([...editArguments.locations, ...state.locations]))
                            : null,
                        onAddPoint: () => _onAddLocation(context)),
                    const SizedBox(height: 20),
                    Text("Locations:",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 5),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: editArguments.locations.length,
                      itemBuilder: (context, index) => LocationWidget(
                          textPrefix: "${index + 1}. ",
                          location: editArguments.locations[index],
                          isReorder: false),
                    ),
                    ReorderableListView.builder(
                      itemCount: state.locations.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => LocationWidget(
                        key: Key(index.toString()),
                        location: state.locations[index],
                        onDelete: (location) => _onDeleteLocation(location, context),
                      ),
                      onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex, context),
                    ),
                    const SizedBox(height: 5),
                    const Divider(height: 2, color: Colors.white),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("People:",
                              style: Theme.of(context).textTheme.bodyMedium),
                          if (!editArguments.isActive)
                            IconButton(
                                onPressed: () => _onPickPerson(context),
                                icon: const Icon(Icons.add))
                        ]),
                    const SizedBox(height: 5),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: editArguments.people.length,
                      itemBuilder: (context, index) => PersonWidget(
                        name: editArguments.people[index].username,
                        picture: editArguments.people[index].picture,
                        onImageUrl: bloc.getImageUrl,
                        onRequestHeaders: bloc.getHeaders,
                      ),
                    ),
                    if (!editArguments.isActive)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.people.length,
                        itemBuilder: (context, index) {
                          var person = state.people[index];
                          return PersonWidget(
                            name: person.username,
                            picture: person.picture,
                            onImageUrl: bloc.getImageUrl,
                            onRequestHeaders: bloc.getHeaders,
                            onDelete: () => bloc.deletePerson(index),
                          );
                        },
                      ),
                    const SizedBox(height: 5),
                    const Divider(height: 2, color: Colors.white),
                    const SizedBox(height: 10),
                    if (state.pictures != null &&
                        state.pictures!.isNotEmpty)
                      Text("Event images:",
                          style: Theme.of(context).textTheme.bodyMedium),
                    if (state.pictures != null &&
                        state.pictures!.isNotEmpty)
                      const SizedBox(height: 5),
                    if (state.pictures != null &&
                        state.pictures!.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.pictures!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                                maxHeight: 100,
                                maxWidth: 100
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(child: Image.network(
                                    bloc.getImageUrl(state.pictures![index].link),
                                    headers: bloc.getHeaders(),
                                    fit: BoxFit.cover,
                                  )),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => bloc.deleteImage(index),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (state.pictures != null &&
                        state.pictures!.isNotEmpty)
                      const SizedBox(height: 10),
                    AppButton.gradient(
                      child: Text("Save changes",
                          style: Theme.of(context).textTheme.bodyMedium),
                      onPressed: () => _onSave(bloc, dateController.text,
                          timeStartController.text, timeEndController.text),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditArguments {
  final int eventId;
  final bool isActive;
  final String initialDate;
  final String initialTimeFrom;
  final String initialTimeTo;
  final List<Location> locations;
  final List<EventPersonResponse> people;
  final List<PictureResponse>? pictures;

  const EditArguments({
    required this.eventId,
    required this.isActive,
    required this.initialDate,
    required this.initialTimeFrom,
    required this.initialTimeTo,
    required this.locations,
    required this.people,
    this.pictures,
  });
}
