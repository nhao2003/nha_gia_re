import 'package:get/get.dart';
import 'package:nha_gia_re/modules/notification/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
