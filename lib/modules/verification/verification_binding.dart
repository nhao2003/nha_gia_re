import 'package:get/get.dart';
import 'package:nha_gia_re/modules/verification/verification_controller.dart';

class VerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() => VerificationController());
  }
}
