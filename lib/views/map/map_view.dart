import 'package:auto_route/auto_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/config/router/router.dart';
import 'package:take_a_walk_app/di.dart';
import 'package:take_a_walk_app/utils/transform_locations_mixin.dart';
import 'package:take_a_walk_app/views/map/bloc/map_bloc.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_scaffold.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

@RoutePage()
class MapPage extends HookWidget with TransformLocationsMixin {
  MapPage({Key? key}) : super(key: key);

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
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoadingState) {
            return AppScaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
                ),
                navigationIndex: 2,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text("Loading...", style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                )
            );
          }
          if (state is MapErrorState) {
            return AppScaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
                ),
                navigationIndex: 2,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Could not load map", style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      AppButton.gradient(
                          child: Text("Retry", style: Theme.of(context).textTheme.bodyMedium),
                          onPressed: () => bloc.getMapLocationData()
                      )
                    ],
                  ),
                )
            );
          }
          state as MapDataState;
          var bounds = state.locationData.isEmpty ?
              null : LatLngBounds.fromPoints(toListLatLonMap(state.locationData));
          if (bounds != null){
            bounds.pad(0.05);
          }
          return AppScaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Map", style: Theme.of(context).textTheme.bodyMedium),
            ),
            fab: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.loading)
                  const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () => _onCenterGPS(context),
                  child: const Icon(Icons.gps_fixed),
                )
              ],
            ),
            navigationIndex: 2,
            child: SizedBox.expand(
              child: FlutterMap(
                mapController: state.controller,
                options: MapOptions(
                    bounds: bounds,
                    center: LatLng(48.148598, 17.107748),
                    zoom: 10),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.takeawalk',
                  ),
                  MarkerLayer(
                    markers: [
                      for (var marker in state.locationData)
                        Marker(
                          point: LatLng(marker.lat, marker.lon),
                          builder: (context) => PopupMenuButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: marker.eventId,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(marker.name),
                                        const Icon(Icons.open_in_new)
                                      ],
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
                                        Text(DateFormat('dd.MM.yyyy')
                                            .format(marker.dateStart))
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
                      if (state.userLocation != null)
                        Marker(
                            point: state.userLocation!,
                            builder: (context) => AvatarGlow(
                                endRadius: 60,
                                glowColor: const Color(0xff2e69ff),
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2e69ff),
                                    shape: BoxShape.circle
                                  ),
                                )
                            ),
                        )
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
