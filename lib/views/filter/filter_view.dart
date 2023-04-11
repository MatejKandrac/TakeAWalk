import 'package:auto_route/annotations.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:take_a_walk_app/config/theme.dart';

import '../../widget/app_button.dart';
import '../../widget/app_scaffold.dart';
import '../../widget/app_swith.dart';

@RoutePage()
class FilterPage extends HookWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("Choose location",
            style: Theme.of(context).textTheme.bodyMedium),
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
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
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
                const AppNumberPicker(),
                const SizedBox(
                  height: 10,
                ),
                const Text('Min people attending:'),
                const SizedBox(
                  height: 5,
                ),
                const AppNumberPicker(),
                const SizedBox(
                  height: 10,
                ),
                const Text('Order by:'),
                const SizedBox(height: 15),
                const AppSegmentedButton(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Text('Show history:'),
                    Spacer(),
                    AppSwitch(),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                AppButton.gradient(
                  onPressed: () {},
                  child: Text("Apply filter",
                      style: Theme.of(context).textTheme.bodyMedium),
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

class AppNumberPicker extends StatefulWidget {
  const AppNumberPicker({Key? key}) : super(key: key);

  @override
  State<AppNumberPicker> createState() => _AppNumberPickerState();
}

class _AppNumberPickerState extends State<AppNumberPicker> {
  int _currentValue = 2;

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      minValue: 1,
      maxValue: 50,
      value: _currentValue,
      onChanged: (value) => setState(() => _currentValue = value),
      step: 1,
      axis: Axis.horizontal,
      itemCount: 3,
      selectedTextStyle: TextStyle(
        color: themeData.colorScheme.primary,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: themeData.colorScheme.secondary),
          shape: BoxShape.circle),
    );
  }
}

class AppSegmentedButton extends StatefulWidget {
  const AppSegmentedButton({Key? key}) : super(key: key);

  @override
  State<AppSegmentedButton> createState() => _AppSegmentedButtonState();
}

class _AppSegmentedButtonState extends State<AppSegmentedButton> {
  OrderType currentType = OrderType.date;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
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
      selected: <OrderType>{currentType},
      onSelectionChanged: (Set<OrderType> newSelection) {
        setState(
          () {
            currentType = newSelection.first;
          },
        );
      },
      multiSelectionEnabled: false,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: themeData.colorScheme.secondary),
      ),
    );
  }
}

// class AppSwitch extends StatefulWidget {
//   const AppSwitch({Key? key}) : super(key: key);
//
//   @override
//   State<AppSwitch> createState() => _AppSwitchState();
// }
//
// class _AppSwitchState extends State<AppSwitch> {
//   bool _isSet = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: _isSet,
//       onChanged: (value) => setState(
//         () {
//           _isSet = !_isSet;
//         },
//       ),
//     );
//   }
// }
