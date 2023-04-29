

import 'package:auto_route/annotations.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:take_a_walk_app/domain/models/responses/location.dart';
import 'package:take_a_walk_app/utils/location_getter_mixin.dart';
import 'package:take_a_walk_app/widget/app_button.dart';
import 'package:take_a_walk_app/widget/app_text_field.dart';
import 'package:take_a_walk_app/widget/map_widget.dart';
import 'package:take_a_walk_app/widget/state_dialog.dart';

@RoutePage()
class PickLocationPage extends HookWidget with LocationMixin {
  const PickLocationPage({Key? key}) : super(key: key);

  _onCenterGps(ValueNotifier<bool> loading, ValueNotifier<LatLng?> position, BuildContext context) async {
    loading.value = true;
    var gps = await getPosition().onError((error, stackTrace) {
      showStateDialog(
        context: context,
        isSuccess: false,
        text: "Could not get location",
        closeOnConfirm: true
      );
      return null;
    });
    if (gps != null) {
      position.value = LatLng(gps.latitude, gps.longitude);
    }
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    var latLon = useState<LatLng?>(null);
    var position = useState<LatLng?>(null);
    var hasName = useState<bool?>(null);
    var loadingLocation = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose location",
            style: Theme.of(context).textTheme.bodyMedium),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: MapWidget(
                    heroTag: -1,
                    onPositionTap: (p0) => latLon.value = p0,
                    bounds: (position.value != null) ? LatLngBounds.fromPoints([position.value!]) : null,
                    layers: [
                      MarkerLayer(
                        markers: [
                          if(latLon.value != null) Marker(
                              point: latLon.value!,
                              anchorPos: AnchorPos.align(AnchorAlign.top),
                              builder: (context) => const Icon(Icons.location_on, color: Colors.red),
                          ),
                          if(position.value != null) Marker(
                            point: position.value!,
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
                      )
                    ],
                    onCenterGps: () => _onCenterGps(loadingLocation, position, context),
                  ),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  controller: nameController,
                  labelText: 'Name',
                  errorText: (hasName.value != null && !hasName.value!) ? "This field is required" : null,
                ),
                const SizedBox(height: 30),
                AppButton.gradient(
                  onPressed: latLon.value == null ? null : () {
                    if (nameController.text.isEmpty) {
                      hasName.value = false;
                    } else {
                      Navigator.of(context).pop(
                          Location(
                              lat: latLon.value!.latitude,
                              lon: latLon.value!.longitude,
                              name: nameController.text
                          )
                      );
                    }
                  },
                  child: Text("Save changes",
                      style: Theme.of(context).textTheme.bodySmall)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
