import 'package:get/get.dart';

import 'conversation_controller.dart';

class ConversationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationController>(() => ConversationController());
  }
}
