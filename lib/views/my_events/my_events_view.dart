
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: Text("My events", style: Theme.of(context).textTheme.bodyMedium),
        ),
        navigationIndex: 0,
        child: Container()
    );
  }
}
