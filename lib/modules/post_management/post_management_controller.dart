import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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

  PostRepository repository = GetIt.instance<PostRepository>();

  Future<List<Post>> getAllPosts() async {
    List<Post> datas = await repository.getUserPosts(GetIt.instance<AuthRepository>().userID!);
    return datas;
  }

  Future<void> getPostsInit() async {
    allPosts.clear();
    pendingPosts.clear();
    expiredPosts.clear();
    hidedPosts.clear();
    rejectedPosts.clear();
    approvedPosts.clear();
    pendingPosts.clear();
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
    await repository.hideOrUnHidePost(post.id, false);
    await getPostsInit();
  }

  void hidePost(Post post) async {
    await repository.hideOrUnHidePost(post.id, true);
    await getPostsInit();
  }

  void editPost(Post post) async {
    print("edit post");
    // edit post

    Get.toNamed(AppRoutes.post, parameters: {
      "id":  post.id,
      'type': post.type.toString(),
    });
  }

  void deletePost(Post post) async {
    await repository.deletePost(post.id);
    await getPostsInit();
  }

  void extensionPost(Post post) async {
    await repository.extendPostExpiryDate(post.id, true);
    await getPostsInit();
  }
}
