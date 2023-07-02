import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/admin_post_detail/admin_post_detail_controller.dart';
import 'package:nha_gia_re/modules/admin_post_manage/admin_post_controller.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';

import 'package:get/get.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_controller.dart';

class AdminPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPostController>(() => AdminPostController());
    // Get.lazyPut<AdminPostDetailController>(() => AdminPostDetailController());
    // Get.lazyPut<AuthRepository>(()=>AuthRepository());
  }
}
