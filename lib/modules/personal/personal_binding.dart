import 'package:get/get.dart';
import 'package:nha_gia_re/modules/personal/personal_controller.dart';

class PersonalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalController>(() => PersonalController());
  }
}
