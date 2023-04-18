

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/views/event/create/create_event/bloc/create_event_bloc.dart';
import 'package:take_a_walk_app/views/event/create/create_event/widgets/location_widget.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

import 'widgets/person_widget.dart';

@RoutePage()
class CreateEventPage extends HookWidget {
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
        BlocProvider.of<CreateEventBloc>(context).addPerson(value as ProfileResponse);
      }
    });
  }

  _onDatePick(BuildContext context, TextEditingController dateController) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000)
    ).then((value) {
      if (value != null) {
        dateController.text = AppConstants.dateFormat.format(value);
      }
    });
  }

  _onDeleteLocation(Location location, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).deleteLocation(location);
  }

  _onReorder(int oldIndex, int newIndex, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).onReorder(oldIndex, newIndex);
  }

  _onDeletePerson(ProfileResponse person, BuildContext context) {
    BlocProvider.of<CreateEventBloc>(context).deletePerson(person);
  }

  _onTimePick(BuildContext context, TextEditingController timeController) {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now())
    ).then((value) {
      if (value != null) {
        timeController.text = value.format(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final dateController = useTextEditingController();
    final startTimeController = useTextEditingController();
    final endTimeController = useTextEditingController();
    final bloc = useMemoized<CreateEventBloc>(() => di());
    return BlocProvider<CreateEventBloc>(
      create: (context) => bloc,
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {

        },
        child: BlocBuilder<CreateEventBloc, CreateEventState>(
          buildWhen: (previous, current) => current is CreateFormState,
          builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text("Create event", style: Theme.of(context).textTheme.bodyMedium),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: nameController,
                        labelText: "Name",
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: dateController,
                        labelText: "Date",
                        inputType: TextInputType.datetime,
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
                          onAddPoint: () => _onAddLocation(context)
                      ),
                      const SizedBox(height: 20),
                      Text("Locations:", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      ReorderableListView.builder(
                        itemCount: (state as CreateFormState).locations.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => LocationWidget(
                          key: Key(index.toString()),
                          location: state.locations[index],
                          onDelete: (location) => _onDeleteLocation(location, context),
                        ),
                        onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex, context),
                      ),
                      const Divider(height: 2, color: Colors.white),
                      const SizedBox(height: 20),
                      Text("People:", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.people.length,
                        itemBuilder: (context, index) => PersonWidget(
                          profile: state.people[index],
                          onDelete: (person) => _onDeletePerson(person, context)
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppButton.outlined(outlineColor: Colors.white,
                          onPressed: () => _onPickPerson(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Add", style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(width: 5),
                              const Icon(Icons.add)
                            ],
                          )
                      ),
                      const SizedBox(height: 20),
                      AppButton.gradient(child: Text("Create event", style: Theme.of(context).textTheme.bodySmall), onPressed: () {})
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
