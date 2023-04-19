import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    this.onAddPoint,
    this.onPositionTap,
    this.height = 300,
    this.borderRadius,
    this.bounds,
    this.layers = const [],
    required this.heroTag
  }) : super(key: key);

  final int heroTag;
  final double height;
  final LatLngBounds? bounds;
  final List<Widget> layers;
  final Function()? onAddPoint;
  final Function(LatLng)? onPositionTap;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (bounds != null) {
      bounds!.pad(0.05);
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: heroTag,
                child: AbsorbPointer(
                  absorbing: onPositionTap == null,
                  child: FlutterMap(
                    options: MapOptions(
                        bounds: bounds,
                        center: LatLng(48.148598, 17.107748),
                        zoom: 10,
                        onTap: (tapPosition, point) {
                          if (onPositionTap != null) {
                            onPositionTap!(point);
                          }
                        },
                    ),
                    nonRotatedChildren: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.takeawalk',
                      ),
                      ...layers
                    ],
                  ),
                ),
              ),
            ),
            if (onAddPoint != null)
              Positioned(
                right: 10,
                bottom: 10,
                child: FloatingActionButton(
                  onPressed: onAddPoint,
                  child: const Icon(Icons.add),
                ),
              )
          ],
        ),
      ),
    );
  }
}
