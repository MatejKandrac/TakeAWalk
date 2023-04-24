import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/views/map/bloc/map_bloc.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';

@RoutePage()
class MapPage extends HookWidget {
  MapPage({Key? key}) : super(key: key);

  MapController mapController = MapController();

  _onCenterGPS(BuildContext context, double lat, double lon) {
    mapController.move(LatLng(lat, lon), 10);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<MapBloc>(() => BlocProvider.of(context));
    useEffect(() {
      bloc.getMapLocationData();
      return null;
    }, const []);
    return BlocListener<MapBloc, MapState>(
      listener: (context, state) {
        // if (state is ProfileFormState) {
        //   _getProfileData(context);
        // }
      },
      child: BlocBuilder<MapBloc, MapState>(
        buildWhen: (previous, current) => current is MapDataState,
        builder: (context, state) {
          return AppScaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
            ),
            fab: FloatingActionButton(
              // onPressed: () {},
              onPressed: () => _onCenterGPS(context, state.locationData[0].lat, state.locationData[0].lon),
              child: const Icon(Icons.gps_fixed),
            ),
            navigationIndex: 2,
            child: SizedBox.expand(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(center: LatLng(state.locationData[0].lat, state.locationData[0].lon), zoom: 10),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.takeawalk',
                  ),
                  MarkerLayer(
                    markers: [
                      for (var marker in state.locationData)
                        Marker(
                          // point: LatLng(48.148598, 17.107748),
                          point: LatLng(marker.lat, marker.lon),
                          builder: (context) => PopupMenuButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [Text(marker.name), const Icon(Icons.open_in_new)],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time_outlined),
                                        Text(
                                            "${DateFormat.Hm().format(marker.dateStart)} - ${DateFormat.Hm().format(marker.dateEnd)}")
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.date_range),
                                        Text(DateFormat('dd.MM.yyyy').format(marker.dateStart))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
