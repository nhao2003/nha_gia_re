import 'package:nha_gia_re/modules/admin_post_manage/admin_post_controller.dart';

import 'package:get/get.dart';

class AdminPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPostController>(() => AdminPostController());
    // Get.lazyPut<AdminPostDetailController>(() => AdminPostDetailController());
    // Get.lazyPut<AuthRepository>(()=>AuthRepository());
  }
}
