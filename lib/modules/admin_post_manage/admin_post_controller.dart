import 'package:flutter/cupertino.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/data/models/create_order.dart';
import 'package:nha_gia_re/data/providers/remote/request/create_order_request.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/repositories/admin_reposotory.dart';
import 'package:nha_gia_re/data/repositories/pay_repository.dart';
import 'package:nha_gia_re/data/providers/remote/request/query_order.dart';

import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/post_repository.dart';
import '../../routers/app_routes.dart';

class AdminPostController extends GetxController {
  AdminRepository repository = GetIt.instance<AdminRepository>();
  PayRepository payRepo = PayRepository();
  late Future<List<Post>> pendingPosts;
  late Future<List<Post>> rejectedPosts;
  bool isAutoPost = false;
  bool isEditing = false;
  late String payResult;
  GlobalKey formkey = GlobalKey();
  final authRepository = GetIt.instance<AuthRepository>();
  int amount = 50000;

  getAllPosts() {
    pendingPosts = repository.getPendingPosts();
    rejectedPosts = repository.getRejectedPosts();
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

  // pay() async {
  // CreateOrderRequest request = CreateOrderRequest(
  //     record: Record(
  //         userId: authRepository.userID!,
  //         amount: amount,
  //         embeddata: "embeddata",
  //         property: "property info"))
  //         Record(userId: authRepository.userID!, membershipPackageId: membershipPackageId, numOfSubscriptionMonth: numOfSubscriptionMonth)
  // PayRepository.createOrder(request).then((value) {
  //   if (value != null) {
  //     FlutterZaloPaySdk.payOrder(zpToken: value.data.zptranstoken)
  //         .listen((event) {
  //       switch (event) {
  //         case FlutterZaloPayStatus.cancelled:
  //           payResult = "User Huỷ Thanh Toán";
  //           Future.delayed(const Duration(seconds: 2), () {
  //             Get.snackbar("Trạng thái", payResult);
  //           });
  //           break;
  //         case FlutterZaloPayStatus.success:
  //           payResult = "Thanh toán thành công";
  //           QueryOrder query = QueryOrder(
  //               record: QueryRecord(
  //                   userId: authRepository.userID!,
  //                   apptransid: value.apptransid,
  //                   postId: "dd"));
  //           PayRepository.createQuery(query).then((value) {
  //             if (value != null && value == true) {
  //               Get.snackbar("Trạng thái", payResult);
  //             } else {
  //               Get.snackbar("Trạng thái", "Thanh toán thất bại");
  //             }
  //           });
  //           break;
  //         case FlutterZaloPayStatus.failed:
  //           payResult = "Thanh toán thất bại";
  //           Future.delayed(const Duration(seconds: 2), () {
  //             Get.snackbar("Trạng thái", payResult);
  //           });
  //           break;
  //         default:
  //           payResult = "Thanh toán thất bại";
  //           Get.snackbar("Trạng thái", payResult);
  //           break;
  //       }
  //     });
  //   }
  // });
}
