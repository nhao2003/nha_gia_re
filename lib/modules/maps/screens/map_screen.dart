import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nha_gia_re/core/utils/map_utils.dart';

class MapViewScreen extends StatefulWidget {
  bool isSelecting = true;
  LatLng location = const LatLng(37.422, -122.084);

  MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late GoogleMapController mapController;
  LatLng? _pickedLocation;
  Location location = Location();

  Future<bool> requestLocationServiceAndPermission() async {
    if (!await MapUtils.requestLocationService()) {
      Get.snackbar(
          "Vị trị đang tắt", "Vui lòng bật vị trí để sử dụng ứng dụng");
      return false;
    }
    if (!await MapUtils.requestLocationPermission()) {
      Get.snackbar("Quyền truy cập vị trí đang tắt",
          "Vui lòng cấp quyền vị trí để sử dụng ứng dụng");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationServiceAndPermission();
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
          GoogleMap(

            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
            },
            onTap: !widget.isSelecting
                ? null
                : (position) {
                    setState(() {
                      _pickedLocation = position;
                    });
                  },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.location.latitude,
                widget.location.longitude,
              ),
            ),
            markers: (_pickedLocation == null && widget.isSelecting)
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId('m1'),
                      position: _pickedLocation ??
                          LatLng(
                            widget.location.latitude,
                            widget.location.longitude,
                          ),
                    ),
                  },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final data = await Location.instance.getLocation();
                    log("${data.latitude}/${data.longitude}");
                    Get.back(result: LatLng(data.latitude!, data.longitude!));
                  },
                  label: const Text("Gửi trí hiện tại"),
                  icon: const Icon(Icons.my_location),
                ),
                if(_pickedLocation != null)
                ElevatedButton.icon(
                  onPressed: () {
                    log("${_pickedLocation!.latitude}/${_pickedLocation!.longitude}");
                    Get.back(result: _pickedLocation);
                  },
                  label: const Text("Gửi vị trí đã chọn"),
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
