import 'package:get/get.dart';
import 'package:nha_gia_re/modules/dashboard/dashboard_controller.dart';

import '../home/home_controller.dart';
import '../personal/personal_controller.dart';
import '../post/post_controller.dart';
import '../post/property_controller.dart';
import '../search/search_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<LandController>(()=> LandController());
    Get.lazyPut<HostelController>(()=> HostelController());
    Get.lazyPut<HouseController>(()=> HouseController());
    Get.lazyPut<ApartmentController>(()=> ApartmentController());
    Get.lazyPut<OfficeController>(()=> OfficeController());
    Get.lazyPut<PropertyController>(() => PropertyController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<PersonalController>(() => PersonalController());
  }
}
