import 'package:flutter/material.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key}) : super(key: key);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool _isSet = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSet,
      onChanged: (value) => setState(
        () {
          _isSet = !_isSet;
        },
      ),
    );
  }
}
