import 'package:get/get.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_controller.dart';


class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(() => PostDetailController());
  }
}
