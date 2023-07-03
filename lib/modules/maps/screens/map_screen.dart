import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/modules/maps/map_controller.dart';

class MapViewScreen extends StatefulWidget {
  late List<Marker> markers;

  MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late final MapController _controller;

  @override
  void initState() {
    _controller = Get.find<MapController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Set<Marker>>(
          future: _controller.initLocation(Get.arguments),
          builder: (
            context,
            snapShot,
          ) {
            if (snapShot.hasData) {
              log("Markers: ${snapShot.data}");
              return GoogleMap(
                  markers: snapShot.data!,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: snapShot.data!.first.position,
                    zoom: 16,
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
