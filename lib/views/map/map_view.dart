import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/views/map/bloc/map_bloc.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

@RoutePage()
class MapPage extends HookWidget {
  MapPage({Key? key}) : super(key: key);

  final MapController mapController = MapController();

  _onCenterGPS(BuildContext context) {
    BlocProvider.of<MapBloc>(context).onCenterGps();
  }

  _onDetail(int value, BuildContext context) {
    AutoRouter.of(context).push(EventDetailRoute(eventId: value));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized<MapBloc>(() => di());
    useEffect(() {
      bloc.getMapLocationData();
      return null;
    }, const []);
    return BlocProvider<MapBloc>(
      create: (context) => bloc,
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapErrorState) {
            showStateDialog(context: context, isSuccess: false, closeOnConfirm: true, text: state.text);
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          buildWhen: (previous, current) => current is MapDataState,
          builder: (context, state) {
            state as MapDataState;
            return AppScaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
              ),
              fab: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.loading) const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    // onPressed: () {},
                    onPressed: () => _onCenterGPS(context),
                    child: const Icon(Icons.gps_fixed),
                  )
                ],
              ),
              navigationIndex: 2,
              child: SizedBox.expand(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      center: (state.gpsPosition != null) ?
                      LatLng(state.gpsPosition!.latitude, state.gpsPosition!.longitude) :
                      LatLng(48.148598, 17.107748),
                      zoom: (state.gpsPosition != null) ? 14 : 10
                  ),
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
                                PopupMenuItem<int>(
                                  value: marker.eventId,
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
                              onSelected: (value) => _onDetail(value, context),
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
      ),
    );
  }
}
