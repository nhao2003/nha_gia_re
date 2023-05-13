import 'package:get/get.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';

import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';
import '../../data/providers/remote/request/filter_request.dart';
import '../../data/repositories/post_repository.dart';

class PostManagementController extends GetxController {
  List<String> typePosts = [
    "Đã đăng",
    "Chờ duyệt",
    "Bị từ chối",
    "Đã ẩn",
    "Hết hạn",
  ];

  PostRepository repository = PostRepository();

  Future<List<Post>> getAllPosts() async {
    List<Post> datas = await repository.getUserPosts(AuthRepository().userID!);
    print(datas[0]);
    return datas;
  }

  void hidePost() {
    print("hide post");
  }

  void edit() {
    print("edit post");
  }

  void deletePost() {
    print("delete post");
  }

  void extensionPost() {
    print("gia han");
  }
}
