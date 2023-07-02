import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';

import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/post_repository.dart';
import '../../routers/app_routes.dart';

class AdminPostController extends GetxController {
  PostRepository repository = PostRepository();
  late Future<List<Post>> pendingPosts;
  bool isAutoPost = false;
  bool isEditing = false;
  GlobalKey formkey = GlobalKey();

  getAllPosts() {
    pendingPosts = repository.getUserPosts(AuthRepository().userID!);
  }

  handleEditAutoForm() {}
  String formatTime(DateTime timestamp) {
    DateTime now = DateTime.now();
    DateTime msgTime = timestamp;
    if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day) {
      return DateFormat.Hm().format(msgTime);
    } else if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day + 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(msgTime);
    }
  }

  // Future<void> getPostsInit() async {
  //   allPosts.clear();
  //   pendingPosts.clear();
  //   expiredPosts.clear();
  //   rejectedPosts.clear();
  //   approvedPosts.clear();
  //   pendingPosts.clear();
  //   allPosts = await getAllPosts();

  //   for (Post post in allPosts) {
  //     switch (post.status) {
  //       case PostStatus.approved:
  //         if (post.expiryDate.isBefore(DateTime.now())) {
  //           expiredPosts.add(post);
  //         } else if (post.isHide) {
  //           hidedPosts.add(post);
  //         } else {
  //           approvedPosts.add(post);
  //         }
  //         break;
  //       case PostStatus.pending:
  //         pendingPosts.add(post);
  //         break;
  //       case PostStatus.rejected:
  //         rejectedPosts.add(post);
  //         break;
  //     }
  //   }
  // }

  void navigateToDetailSceen(Post post) {
    Get.toNamed(AppRoutes.admin_post_detail, arguments: post);
  }
}
