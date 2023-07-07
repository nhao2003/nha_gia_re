import 'package:get/get.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';
import 'package:nha_gia_re/modules/user_profile/user_profile_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
