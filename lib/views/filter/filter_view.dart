import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:take_a_walk_app/config/theme.dart';

import '../../domain/models/requests/filter_data.dart';
import '../../widget/app_button.dart';
import '../../widget/app_scaffold.dart';

@RoutePage()
class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var date = null;
  var places = 2;
  var peopleGoing = 2;
  var order = OrderType.name;
  var showHistory = false;

  var dateError = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("Choose location", style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: true,
      ),
      navigationIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (e) => (e ?? DateTime.now().subtract(Duration(days: 1))).isBefore(DateTime.now().subtract(Duration(days: 1))) ? 'Can not pick date from past' : null,
                  firstDate: DateTime.now(),
                  onDateSelected: (DateTime value) {
                    date = value;
                    print(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Places planned:'),
                const SizedBox(
                  height: 5,
                ),
                NumberPicker(
                  minValue: 1,
                  maxValue: 50,
                  value: places,
                  onChanged: (value) => setState(() {
                    places = value;
                  }),
                  step: 1,
                  axis: Axis.horizontal,
                  itemCount: 3,
                  selectedTextStyle: TextStyle(
                    color: themeData.colorScheme.primary,
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: themeData.colorScheme.secondary), shape: BoxShape.circle),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Min people attending:'),
                const SizedBox(
                  height: 5,
                ),
                NumberPicker(
                  minValue: 1,
                  maxValue: 50,
                  value: peopleGoing,
                  onChanged: (value) => setState(() {
                    peopleGoing = value;
                  }),
                  step: 1,
                  axis: Axis.horizontal,
                  itemCount: 3,
                  selectedTextStyle: TextStyle(
                    color: themeData.colorScheme.primary,
                  ),
                  decoration:
                      BoxDecoration(border: Border.all(color: themeData.colorScheme.secondary), shape: BoxShape.circle),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Order by:'),
                const SizedBox(height: 15),
                SegmentedButton(
                  segments: const <ButtonSegment<OrderType>>[
                    ButtonSegment<OrderType>(
                      value: OrderType.name,
                      label: Text('Name'),
                      icon: Icon(Icons.person),
                    ),
                    ButtonSegment<OrderType>(
                      value: OrderType.date,
                      label: Text('Date'),
                      icon: Icon(Icons.date_range),
                    ),
                    ButtonSegment<OrderType>(
                      value: OrderType.time,
                      label: Text('Time'),
                      icon: Icon(Icons.timer),
                    ),
                  ],
                  selected: <OrderType>{order},
                  onSelectionChanged: (Set<OrderType> newSelection) {
                    setState(
                      () {
                        order = newSelection.first;
                      },
                    );
                  },
                  multiSelectionEnabled: false,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: themeData.colorScheme.secondary),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Show history:'),
                    const Spacer(),
                    Switch(
                      value: showHistory,
                      onChanged: (value) => setState(() {
                        showHistory = value;
                      }),
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                AppButton.gradient(
                  onPressed: () => AutoRouter.of(context).pop(FilterData(
                      date: date,
                      places: places,
                      peopleGoing: peopleGoing,
                      order: order.name,
                      showHistory: showHistory)),
                  child: Text("Apply filter", style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


enum OrderType { name, date, time }
