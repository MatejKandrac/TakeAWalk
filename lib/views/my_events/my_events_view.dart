
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MyEventsPage extends StatelessWidget {
  const MyEventsPage({Key? key}) : super(key: key);

  _onOpenFilter(BuildContext context) {
    AutoRouter.of(context).push(const FilterRoute());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: Text("My events", style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            IconButton(
                onPressed: () => _onOpenFilter(context),
                icon: const Icon(Icons.filter_alt_rounded)
            ),
            const SizedBox(width: 10),
          ],
        ),
        navigationIndex: 0,
        fab: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => AutoRouter.of(context).push(const CreateEventRoute()),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        )
    );
  }
}
