
import 'package:flutter/material.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/app_button.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    Key? key,
    required this.event,
    required this.onTap,
    required this.status,
    this.onAccept,
    this.onDecline
  }) : super(key: key);

  final EventObject event;
  final Status status;
  final Function() onTap;
  final Function()? onAccept;
  final Function()? onDecline;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: event.start.isBefore(DateTime.now()) ? const Color(0xff7740c2) : null,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MapWidget(
              heroTag: event.eventId,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(event.name, style: Theme.of(context).textTheme.bodyLarge),
                  Text(event.owner, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time_outlined),
                            const SizedBox(width: 5),
                            Text("${AppConstants.timeFormat.format(event.start)} - ${AppConstants.timeFormat.format(event.end)}",
                              style: Theme.of(context).textTheme.bodySmall,)
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_2_outlined),
                            const SizedBox(width: 5),
                            Text(event.peopleGoing.toString(), style: Theme.of(context).textTheme.bodySmall,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.date_range),
                            const SizedBox(width: 5),
                            Text("${AppConstants.dateOnlyFormat.format(event.start)} - ${AppConstants.dateOnlyFormat.format(event.start)}",
                              style: Theme.of(context).textTheme.bodySmall,)
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            Text(event.places.toString(), style: Theme.of(context).textTheme.bodySmall,)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (status == Status.PENDING) Row(
                    children: [
                      Expanded(
                        child: AppButton.outlined(
                            outlineColor: const Color(0xffF20AB8),
                            onPressed: onDecline,
                            child: Text("Decline")
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton.primary(
                            onPressed: onAccept,
                            child: Text("Accept")
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
