import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nha_gia_re/data/models/message.dart';

class MapViewScreen extends StatefulWidget {
  late List<Marker> markers;

  MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Future<Set<Marker>> initLocation() async {
    Set<Marker> markers = {};
    if (Get.arguments is Message) {
      Message message = Get.arguments;

      Marker marker = Marker(
        markerId: MarkerId(message.id),
        position: message.location!,
      );
      markers.add(marker);
    }
    log(markers.toString());
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Set<Marker>>(
          future: initLocation(),
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
