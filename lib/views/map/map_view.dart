import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MapPage extends HookWidget {
  const MapPage({Key? key}) : super(key: key);

  _onMapPick(BuildContext context) {
    AutoRouter.of(context).push(const LocationPickRoute());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
      ),
      navigationIndex: 2,
      child: Container(
        child: ElevatedButton(
          onPressed: () => _onMapPick(context),
          child: const Text('Location pick'),
        ),
      ),
    );
  }
}
