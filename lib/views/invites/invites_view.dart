

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/event_item.dart';

@RoutePage()
class InvitesPage extends StatelessWidget {
  InvitesPage({Key? key}) : super(key: key);

  List<EventResponse> events = [
    EventResponse(
        id: 0,
        name: "Rozbijacka",
        status: Status.PENDING,
        owner: ProfileResponse(username: "Matej", email: ""),
        dateStart: DateTime(2023, 1, 1),
        dateEnd: DateTime(2023, 12, 5),
        locations: [Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"), Location(lat: 48.148598, lon: 17.107748, name: "Co ja viem")],
        profiles: [
          ProfileResponse(username: "Matejko", email: "")
        ]),
    EventResponse(
        id: 1,
        name: "TestEvent",
        owner: ProfileResponse(username: "Matej", email: ""),
        dateStart: DateTime(2023,12,4),
        dateEnd: DateTime(2023, 12, 5),
        status: Status.ACCEPTED,
        locations: [Location(lat: 48.140030, lon: 17.104622, name: "Bratislavsky hrad"), Location(lat: 17.107748, lon: 17.107748, name: "Co ja viem")],
        profiles: [
          ProfileResponse(username: "Matejko", email: "")
        ]),
  ];

  _onOpenFilter(BuildContext context) {}

  _onDetail(BuildContext context, int index) {
    AutoRouter.of(context).push(InviteDetailRoute(event: events[index]));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Invites", style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            IconButton(
                onPressed: () => _onOpenFilter(context),
                icon: const Icon(Icons.filter_alt_rounded)
            ),
            const SizedBox(width: 10),
          ],
        ),
        navigationIndex: 1,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) => EventItem(
                event: events[index],
                onTap: () => _onDetail(context, index),
                onDecline: () {},
                onAccept: () {},
              ),
            )
        ),
    );
  }
}
