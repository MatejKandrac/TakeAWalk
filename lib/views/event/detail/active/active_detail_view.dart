
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';

@RoutePage()
class ActiveDetailPage extends StatelessWidget {
  const ActiveDetailPage({Key? key, required this.event}) : super(key: key);
  final EventResponse event;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
