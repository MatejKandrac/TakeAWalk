
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
        ),
        navigationIndex: 2,
        child: Container()
    );
  }
}
