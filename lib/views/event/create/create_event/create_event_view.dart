

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/views/event/create/create_event/widgets/location_widget.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';

import 'widgets/person_widget.dart';

@RoutePage()
class CreateEventPage extends HookWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  final List<ProfileResponse> people = const [
    ProfileResponse(username: "Matejko", email: ""),
    ProfileResponse(username: "Tomasko", email: "")
  ];

  _onAddLocation(BuildContext context) {
    AutoRouter.of(context).push(const PickLocationRoute()).then((value) {
      if (value != null) {

      }
    });
  }

  _onPickPerson(BuildContext context) {
    AutoRouter.of(context).push(const PickPersonRoute());
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
    return Scaffold(
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
                ReorderableListView(
                  shrinkWrap: true,
                    children: [
                      LocationWidget(
                        key: Key(0.toString()),
                          location: Location(
                            lat: 19,
                            lon: 20,
                            name: "Bratislavsky hrad"
                          ),
                          onDelete: (location) {},
                      ),
                      LocationWidget(
                        key: Key(1.toString()),
                        location: Location(
                            lat: 19,
                            lon: 20,
                            name: "Mladost intrak"
                        ),
                        onDelete: (location) {},
                      )
                    ],
                    onReorder: (oldIndex, newIndex) {

                    },
                ),
                const Divider(height: 2, color: Colors.white),
                const SizedBox(height: 20),
                Text("People:", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: people.length,
                  itemBuilder: (context, index) => PersonWidget(
                    profile: people[index],
                    onDelete: (person) {}
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
    );
  }
}
