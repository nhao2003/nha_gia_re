import 'package:nha_gia_re/modules/home/home_controller.dart';
import 'package:nha_gia_re/modules/notification/notification_binding.dart';
import 'package:nha_gia_re/modules/post_management/post_management_controller.dart';

import 'tab_controller.dart';
import 'package:get/get.dart';

class TabBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabNavController>(() => TabNavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostManagementController>(() => PostManagementController());
    Get.lazyPut<NotificationBinding>(() => NotificationBinding());
  }
}
