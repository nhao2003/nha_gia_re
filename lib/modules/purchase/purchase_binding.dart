import 'package:get/get.dart';
import 'package:nha_gia_re/modules/purchase/purchase_controller.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_screens.dart';

class PurchaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseController>(() => PurchaseController());
  }
}
