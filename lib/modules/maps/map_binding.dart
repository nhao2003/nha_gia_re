import 'package:get/get.dart';
import 'map_controller.dart';

class MapsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(() => MapController());
  }
}
