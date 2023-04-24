

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/domain/models/responses/search_person_response.dart';
import 'package:take_a_walk_app/utils/transform_locations_mixin.dart';
import 'package:take_a_walk_app/views/event/create/create_event/bloc/create_event_bloc.dart';
import 'package:take_a_walk_app/widget/location_widget.dart';
import 'package:take_a_walk_app/widget/loading_dialog.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

import '../../../../widget/person_widget.dart';

@RoutePage()
class CreateEventPage extends HookWidget with TransformLocationsMixin {
  const CreateEventPage({Key? key}) : super(key: key);

  _onAddLocation(BuildContext context) {
    AutoRouter.of(context).push(const PickLocationRoute()).then((value) {
      if (value != null) {
        BlocProvider.of<CreateEventBloc>(context).addLocation(value as Location);
      }
    });
  }

  _onPickPerson(BuildContext context) {
    AutoRouter.of(context).push(const PickPersonRoute()).then((value) {
      if (value != null) {
        BlocProvider.of<CreateEventBloc>(context).addPerson(value as SearchPersonResponse);
      }
    });
  }

  _onDatePick(BuildContext context, TextEditingController dateController) {
    showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
    ).then((value) {
      if (value != null) {
        dateController.text = "${AppConstants.dateFormat.format(value.start)} - ${AppConstants.dateFormat.format(value.end)}";
      }
    });
  }

  _onDeleteLocation(Location location, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).deleteLocation(location);
  }

  _onReorder(int oldIndex, int newIndex, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).onReorder(oldIndex, newIndex);
  }

  _onDeletePerson(SearchPersonResponse person, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).deletePerson(person);
  }

  _onTimePick(BuildContext context, TextEditingController timeController) {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now())
    ).then((value) {
      if (value != null) {
        var dateTime = DateTime.now().copyWith(
          hour: value.hour,
          minute: value.minute
        );
        timeController.text = AppConstants.timeFormat.format(dateTime);
      }
    });
  }

  _onWeatherDetail(String dateText, Location location, BuildContext context) {
    AutoRouter.of(context).push(ForecastRoute(dateRange: dateText, location: location));
  }

  _weatherEnabled(String dateText, List<Location> locations) => dateText.isNotEmpty && locations.isNotEmpty;

  _onConfirm(String name, String date, String timeStart, String timeEnd, String description, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).createEvent(name, date, timeStart, timeEnd, description);
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final dateController = useTextEditingController();
    final startTimeController = useTextEditingController();
    final endTimeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final scrollController = useScrollController();
    final bloc = useMemoized<CreateEventBloc>(() => di());
    var loadingDialogShowing = useMemoized<bool>(() => false);
    return BlocProvider<CreateEventBloc>(
      create: (context) => bloc,
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if (loadingDialogShowing) {
            loadingDialogShowing = false;
            Navigator.of(context).pop();
          }
          if (state is CreateLoadingState) {
            loadingDialogShowing = true;
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialog(loadingText: "Creating event...")
            );
          }
          if (state is CreateSuccessState) {
            showStateDialog(
                context: context,
                isSuccess: true,
                text: "Event successfully created!"
            ).then((value) => Navigator.of(context).pop());
          }
          if (state is CreateFormState) {
            if (state.nameError != null || state.timeToError != null || state.timeFromError != null || state.dateError != null) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
              });
            }
            if (state.dialogErrorText != null) {
              showStateDialog(
                  context: context,
                  isSuccess: false,
                  closeOnConfirm: true,
                  text: state.dialogErrorText!
              );
            }
          }
        },
        child: BlocBuilder<CreateEventBloc, CreateEventState>(
          buildWhen: (previous, current) => current is CreateFormState,
          builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text("Create event", style: Theme.of(context).textTheme.bodyMedium),
              ),
              body: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: nameController,
                        labelText: "Name",
                        errorText: (state as CreateFormState).nameError,
                      ),
                      const SizedBox(height: 10),
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
                              controller: startTimeController,
                              labelText: "From",
                              errorText: state.timeFromError,
                              icon: InkWell(
                                onTap: () => _onTimePick(context, startTimeController),
                                child: const Icon(Icons.access_time_outlined),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField(
                              controller: endTimeController,
                              labelText: "To",
                              errorText: state.timeToError,
                              icon: InkWell(
                                onTap: () => _onTimePick(context, endTimeController),
                                child: const Icon(Icons.access_time_outlined),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      MapWidget(
                          heroTag: -1,
                          layers: [
                            if (state.locations.isNotEmpty) MarkerLayer(
                              markers: [
                                for (var position in toListLatLon(state.locations))
                                  Marker(
                                      anchorPos: AnchorPos.align(AnchorAlign.top),
                                      point: position,
                                      builder: (context) => const Icon(Icons.location_on, color: Colors.red)
                                  )
                              ],
                            )
                          ],
                          bounds: state.locations.isNotEmpty ? LatLngBounds.fromPoints(toListLatLon(state.locations)) : null,
                          onAddPoint: () => _onAddLocation(context)
                      ),
                      const SizedBox(height: 20),
                      Text("Locations:", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
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
                      const Divider(height: 2, color: Colors.white),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("People:", style: Theme.of(context).textTheme.bodyMedium),
                          IconButton(onPressed: () => _onPickPerson(context), icon: const Icon(Icons.add))
                        ]
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.people.length,
                        itemBuilder: (context, index) {
                          var person = state.people[index];
                          return PersonWidget(
                              name: person.username,
                              bio: person.bio,
                              picture: person.picture,
                              onDelete: () => _onDeletePerson(person, context)
                          );
                        },
                      ),
                      const Divider(height: 2, color: Colors.white),
                      const SizedBox(height: 10),
                      Text("Description", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 5),
                      AppTextField(
                          controller: descriptionController,
                          maxLines: 5,
                          hint: "Event description... (Optional)",
                      ),
                      const SizedBox(height: 20),
                      AppButton.outlined(
                          outlineColor: Colors.white,
                          onPressed: _weatherEnabled(dateController.text, state.locations) ?
                              () => _onWeatherDetail(dateController.text, state.locations[0], context) : null,
                          child: const Text("See forecast"),
                      ),
                      const SizedBox(height: 20),
                      AppButton.gradient(
                          child: Text("Create event", style: Theme.of(context).textTheme.bodySmall),
                          onPressed: () => _onConfirm(
                              nameController.text, dateController.text,
                              startTimeController.text, endTimeController.text,
                              descriptionController.text, context)
                      )
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
