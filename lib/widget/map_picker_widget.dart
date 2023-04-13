import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPickerWidget extends StatelessWidget {
  const MapPickerWidget({
    Key? key,
    this.onAddPoint,
    this.height = 300,
    this.borderRadius,
    required this.heroTag
  }) : super(key: key);

  final int heroTag;
  final double height;
  final Function()? onAddPoint;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
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
                  absorbing: true,
                  child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(48.148598, 17.107748),
                        zoom: 10
                    ),
                    nonRotatedChildren: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.takeawalk',
                      )
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
