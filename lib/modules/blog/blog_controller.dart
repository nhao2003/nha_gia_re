import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nha_gia_re/data/models/blog.dart';

class BlogController extends GetxController {
  Future<List<Blog>> getBlogs() async {
    await Future.delayed(const Duration(seconds: 2));
    return Blog.fakeBlogList;
  }
}