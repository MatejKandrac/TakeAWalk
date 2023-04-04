

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
          automaticallyImplyLeading: false,
        ),
        navigationIndex: 3,
        child: Container()
    );
  }
}
