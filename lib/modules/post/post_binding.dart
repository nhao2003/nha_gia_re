import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';

import 'package:get/get.dart';
class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyController>(() => PropertyController());
    Get.lazyPut<AuthRepository>(()=>AuthRepository());
  }
}
