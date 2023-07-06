import 'package:nha_gia_re/modules/home/home_controller.dart';
import 'package:nha_gia_re/modules/notification/notification_controller.dart';
import 'package:nha_gia_re/modules/personal/personal_controller.dart';
import 'package:nha_gia_re/modules/post_management/post_management_controller.dart';
import '../blog/blog_controller.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';
import 'tab_controller.dart';
import 'package:get/get.dart';

class TabBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabNavController>(() => TabNavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostManagementController>(() => PostManagementController());
    Get.lazyPut<BlogController>(() => BlogController());
    Get.lazyPut<PersonalController>(() => PersonalController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
