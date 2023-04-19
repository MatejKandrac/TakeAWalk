

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/config/constants.dart';
import 'package:take_a_walk_app/domain/models/responses/event_response.dart';
import 'package:take_a_walk_app/views/event/create/create_event/widgets/location_widget.dart';
import 'package:take_a_walk_app/views/event/create/create_event/widgets/person_widget.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class InviteDetailPage extends StatelessWidget {
  const InviteDetailPage({Key? key, required this.event}) : super(key: key);
  final EventResponse event;

  List<LatLng> _getPoints() {
    var list = event.locations.map((e) => LatLng(e.lat, e.lon)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var points = _getPoints();
    return AppScaffold(
        appBar: AppBar(
          title: Text(event.name),
        ),
        navigationIndex: 1,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Host: ${event.owner.username}"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.date_range, color: Color(0xff7740c2)),
                        const SizedBox(width: 5),
                        Text(
                          AppConstants.dateFormat.format(event.dateStart),
                          style: Theme.of(context).textTheme.bodySmall
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time_outlined, color: Color(0xff7740c2)),
                        const SizedBox(width: 5),
                        Text(
                            "${AppConstants.timeFormat.format(event.dateStart)} - ${AppConstants.timeFormat.format(event.dateEnd)}",
                            style: Theme.of(context).textTheme.bodySmall
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 300,
                    child: Hero(
                      tag: event.id,
                      child: FlutterMap(
                        options: MapOptions(
                            bounds: LatLngBounds.fromPoints(points),
                            minZoom: 0,
                            maxZoom: 18,
                            zoom: 10
                        ),
                        nonRotatedChildren: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.takeawalk',
                          ),
                          MarkerLayer(
                            markers: [
                              for (var point in points)
                                Marker(
                                  point: point,
                                  builder: (context) => const Icon(Icons.location_on, color: Colors.red)
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text("Locations:", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: event.locations.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => LocationWidget(
                    key: Key(0.toString()),
                    isReorder: false,
                    location: event.locations[index],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(height: 2, color: Colors.white),
                const SizedBox(height: 20),
                Text("People:", style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: event.profiles.length,
                  itemBuilder: (context, index) => PersonWidget(
                      name: event.profiles[index].username,
                      bio: event.profiles[index].bio,
                      picture: event.profiles[index].image,
                      onDelete: () {},
                  ),
                ),
                const SizedBox(height: 10),
                if (event.status == Status.PENDING) Row(
                  children: [
                    Expanded(
                      child: AppButton.outlined(
                          outlineColor: const Color(0xffF20AB8),
                          onPressed: () {},
                          child: const Text("Decline")
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppButton.gradient(
                          onPressed: () {},
                          child: const Text("Accept")
                      ),
                    ),
                  ],
                ),
                if (event.status == Status.ACCEPTED)
                  AppButton.gradient(child: const Text("Leave event"), onPressed: () {}),
                const SizedBox(height: 10),
              ],
            ),
          ),
        )
    );
  }
}
