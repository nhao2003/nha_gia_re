import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/utils/map_utils.dart';
import '../../data/models/message.dart';

class MapController extends GetxController {
  Future<Set<Marker>> initLocation(dynamic arguments) async {
    Set<Marker> markers = {};
    if (arguments is Message) {
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

  late Rx<LatLng?> pickedLocation = Rx(null);

  void onMapTap(LatLng pos) {
    pickedLocation.value = pos;
  }

  Future<void> pickCurrentPosition() async {
    final data = await Location.instance.getLocation();
    log("${data.latitude}/${data.longitude}");
    Get.back(result: LatLng(data.latitude!, data.longitude!));
  }

  void pickPickedLocation() {
    log("${pickedLocation.value!.latitude}/${pickedLocation.value!.longitude}");
    Get.back(result: pickedLocation.value);
  }
}
