import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class MapPage extends HookWidget {
  const MapPage({Key? key}) : super(key: key);

  void _onCenterGPS() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
        ),
        fab: FloatingActionButton(
          onPressed: _onCenterGPS,
          child: const Icon(Icons.gps_fixed),
        ),
        navigationIndex: 2,
        child: SizedBox.expand(
          child: FlutterMap(
            options: MapOptions(center: LatLng(48.148598, 17.107748), zoom: 10),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.takeawalk',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(48.148598, 17.107748),
                    builder: (context) => PopupMenuButton(
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sample event"),
                                    const Icon(Icons.open_in_new)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_outlined),
                                    Text("12:00")
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    Text("24.12.20022")
                                  ],
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
