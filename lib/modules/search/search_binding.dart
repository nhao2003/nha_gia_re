import 'my_search_controller.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySearchController>(() => MySearchController());
  }
}
