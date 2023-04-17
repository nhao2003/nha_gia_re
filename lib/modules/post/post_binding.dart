import 'package:nha_gia_re/data/models/property.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';

import 'post_controller.dart';
import 'package:get/get.dart';
class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<LandController>(()=> LandController());
    Get.lazyPut<HostelController>(()=> HostelController());
    Get.lazyPut<HouseController>(()=> HouseController());
    Get.lazyPut<ApartmentController>(()=> ApartmentController());
    Get.lazyPut<OfficeController>(()=> OfficeController());
    Get.lazyPut<PropertyController>(() => PropertyController());
  }
}