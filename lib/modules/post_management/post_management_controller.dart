import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import '../../data/models/properties/post.dart';
import '../../data/repositories/post_repository.dart';

class PostManagementController extends GetxController {
  List<Post> allPosts = [];
  RxList<Post> pendingPosts = <Post>[].obs;
  RxList<Post> approvedPosts = <Post>[].obs;
  RxList<Post> rejectedPosts = <Post>[].obs;
  RxList<Post> hidedPosts = <Post>[].obs;
  RxList<Post> expiredPosts = <Post>[].obs;

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

  Future<void> getPostsInit() async {
    allPosts = await getAllPosts();

    for (Post post in allPosts) {
      switch (post.status) {
        case PostStatus.approved:
          if (post.expiryDate.isBefore(DateTime.now())) {
            hidedPosts.add(post);
          } else {
            approvedPosts.add(post);
          }
          break;
        case PostStatus.pending:
          pendingPosts.add(post);
          break;
        case PostStatus.rejected:
          rejectedPosts.add(post);
          break;
      }
    }
  }

  void showPost() {
    print("Hien tin");
  }

  void hidePost() {
    print("hide post");
  }

  void editPost() {
    print("edit post");
  }

  void deletePost() {
    print("delete post");
  }

  void extensionPost() {
    print("gia han");
  }
}
