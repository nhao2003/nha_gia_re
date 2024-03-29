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
import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';
import '../../data/models/user_info.dart';
import '../../data/providers/remote/request/filter_request.dart';
import '../../data/repositories/user_repository.dart';

class PostDetailController extends GetxController {
  // code controller here
  // define variable and function
  Post? post;
  late UserInfo userInfo;
  late List<Post> relatedPost;
  late bool isYourPost = false;
  bool isLoading = false;
  RxBool liked = false.obs;
  late RxInt numOfLikes = 0.obs;


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

  Future<List<dynamic>> init(dynamic arg) async {

    final repo = GetIt.instance<UserRepository>();
    PostRepository postRepo = GetIt.instance<PostRepository>();
    PostFilter filter = PostFilter(
      orderBy: OrderBy.priceAsc,
      postedBy: PostedBy.all,
      from: 0,
      to: 10,
      provinceCode: post?.address.cityCode,
    );
    if (arg is Post) {
      post = arg;
    }
    if(arg is String)
    {
      post = await postRepo.getPostFromId(arg);
    }
    final data = Future.wait([
      repo.getUserInfo(post?.userID),
      postRepo.getPostDetail(post!.id, post!.type),
      postRepo.hasLikePost(post!.id),
      postRepo.getAllPosts(
        filter,
      )
    ]);
    return data;
  }

  void likePost() async {
    PostRepository postRepo = GetIt.instance<PostRepository>();
    if (!liked.value && !isLoading) {
      isLoading = true;
      await postRepo.likePost(post!.id).then((value) {
          liked.value = true;
          numOfLikes.value++;
        isLoading = false;
      });
    } else if (liked.value && !isLoading) {
      isLoading = true;
      await postRepo.unlikePost(post!.id).then((value) {
          liked.value = false;  
          numOfLikes.value--;
        isLoading = false;
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
