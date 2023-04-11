import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MyEventsPage extends HookWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  _onChat(BuildContext context) {
    AutoRouter.of(context).push(const ChatRoute());
  }

  _onFindPerson(BuildContext context) {
    AutoRouter.of(context).push(const PickPersonRoute());
  }

  _onFilter(BuildContext context) {
    AutoRouter.of(context).push(const FilterRoute());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("My events", style: Theme.of(context).textTheme.bodyMedium),
      ),
      navigationIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _onChat(context),
              child: const Text('Chat'),
            ),
            ElevatedButton(
              onPressed: () => _onFindPerson(context),
              child: const Text('Find person'),
            ),
            ElevatedButton(
              onPressed: () => _onFilter(context),
              child: const Text('Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
