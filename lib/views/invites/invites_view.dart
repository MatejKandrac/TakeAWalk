

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class InvitesPage extends StatelessWidget {
  const InvitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Invites", style: Theme.of(context).textTheme.bodyMedium),
        ),
        navigationIndex: 1,
        child: Container()
    );
  }
}
