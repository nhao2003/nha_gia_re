import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/utils/map_utils.dart';
import '../map_controller.dart';

class MapPickerScreen extends StatefulWidget {
  bool isSelecting = true;
  LatLng location = const LatLng(37.422, -122.084);

  MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  Location location = Location();
  late final MapController _controller;

  @override
  void initState() {
    _controller = Get.find<MapController>();
    _controller.requestLocationServiceAndPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(
            () => GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: !widget.isSelecting ? null :_controller.onMapTap,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.location.latitude,
                  widget.location.longitude,
                ),
              ),
              markers: (_controller.pickedLocation.value == null &&
                      widget.isSelecting)
                  ? {}
                  : {
                      Marker(
                        markerId: const MarkerId('m1'),
                        position: _controller.pickedLocation.value ??
                            LatLng(
                              widget.location.latitude,
                              widget.location.longitude,
                            ),
                      ),
                    },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _controller.pickCurrentPosition,
                  label: const Text("Chọn vị trí hiện tại"),
                  icon: const Icon(Icons.my_location),
                ),
                if (_controller.pickedLocation.value != null)
                  ElevatedButton.icon(
                    onPressed: _controller.pickPickedLocation,
                    label: const Text("Chọn vị trí đã ghim"),
                    icon: const Icon(Icons.add_location),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
