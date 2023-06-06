import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import '../../data/models/properties/post.dart';
import '../../data/repositories/post_repository.dart';
import '../../routers/app_routes.dart';

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
    return datas;
  }

  Future<void> getPostsInit() async {
    allPosts = await getAllPosts();

    for (Post post in allPosts) {
      switch (post.status) {
        case PostStatus.approved:
          if (post.expiryDate.isBefore(DateTime.now())) {
            expiredPosts.add(post);
          } else if (post.isHide) {
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

  void navigateToDetailSceen(Post post) {
    Get.toNamed(AppRoutes.post_detail, arguments: post);
  }

  void showPost(Post post) async {
    print("Hien tin");
    await repository.hideOrUnHidePost(post.id, false);
    await getPostsInit();
  }

  void hidePost(Post post) async {
    print("hide post");
    await repository.hideOrUnHidePost(post.id, true);
    await getPostsInit();
  }

  void editPost(Post post) async {
    print("edit post");
    // edit post
  }

  void deletePost(Post post) async {
    print("delete post");
    await repository.deletePost(post.id);
    await getPostsInit();
  }

  void extensionPost(Post post) async {
    print("gia han");
    await repository.extendPostExpiryDate(post.id, true);
    await getPostsInit();
  }
}
