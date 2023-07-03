
import 'package:get/get.dart';

import 'address_controller.dart';
class AddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}
