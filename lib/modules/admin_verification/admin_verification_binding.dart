import 'package:get/get.dart';

import 'admin_verification_controller.dart';

class AdminVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminVerificationController>(
        () => AdminVerificationController());
  }
}
