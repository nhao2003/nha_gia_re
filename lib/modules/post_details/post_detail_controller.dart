import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/modules/post_details/widget/apartment_details.dart';
import 'package:nha_gia_re/modules/post_details/widget/house_detail.dart';
import 'package:nha_gia_re/modules/post_details/widget/land_details.dart';
import 'package:nha_gia_re/modules/post_details/widget/motel_details.dart';
import 'package:nha_gia_re/modules/post_details/widget/office_details.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/properties/post.dart';
import '../../data/models/user_info.dart';
import '../../data/repositories/user_repository.dart';

class PostDetailController extends GetxController {
  // code controller here
  // define variable and function
  late Post post;
  late UserInfo userInfo;

  late bool isYourPost = false;
  bool isLoading = false;
  RxBool liked = false.obs;
  late RxInt numOfLikes = 0.obs;

  void initArg(dynamic arg) {
    if (arg is Post) {
      post = arg;
      var auth = GetIt.instance<AuthRepository>();
      if (post.userID == auth.userID) {
        isYourPost = true;
      }
    }
  }

  Widget postDetail(Post post) {
    if (post is Apartment) {
      return ApartmentDetails(apartment: post);
    } else if (post is House) {
      return HouseDetails(house: post);
    } else if (post is Land) {
      return LandDetails(land: post);
    } else if (post is Office) {
      return OfficeDetails(office: post);
    } else if (post is Motel) {
      return MotelDetails(motel: post);
    } else {
      return const SizedBox();
    }
  }

  Future<List<dynamic>> init() async {
    final repo = GetIt.instance<UserRepository>();
    PostRepository postRepo = GetIt.instance<PostRepository>();
    final data = Future.wait([
      repo.getUserInfo(post.userID),
      postRepo.getPostDetail(post),
      postRepo.hasLikePost(post.id)
    ]);
    return data;
  }

  void likePost() async {
    PostRepository postRepo = GetIt.instance<PostRepository>();
    if (!liked.value && !isLoading) {
      isLoading = true;
      await postRepo.likePost(post.id).then((value) {
        liked.value = true;
        isLoading = false;
        numOfLikes.value++;
      });
    } else if (liked.value && !isLoading) {
      isLoading = true;
      await postRepo.unlikePost(post.id).then((value) {
        liked.value = false;
        isLoading = false;
        numOfLikes.value--;
      });
    }
  }

  void navToChat() {
    Get.toNamed(AppRoutes.chat, arguments: userInfo);
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.personal, arguments: userInfo);
  }

  void launchPhone() {
    launchUrl(Uri.parse("tel://${userInfo.phoneNumber}"));
  }

  void launchSms() {
    launchUrl(Uri.parse("sms://${userInfo.phoneNumber}"));
  }
}
