import 'package:get/get.dart';
import 'package:nha_gia_re/modules/blog/blog_controller.dart';

class BlogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }
}
