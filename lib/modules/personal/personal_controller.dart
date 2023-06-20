import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/providers/remote/remote_data_source.dart';
import '../../data/repositories/chat_repository.dart';

class PersonalController extends GetxController {
  late UserInfo userInfo;
  var auth = AuthRepository();
  var authId = AuthRepository().userID;
  late RxBool isFollowing = true.obs;
  bool isLoading = false;
  final remoteDataSourceImpl = RemoteDataSource();
  ChatRepository chatRepository = GetIt.instance<ChatRepository>();

  bool check()
  {
    return authId == userInfo.uid;
  }

  Future<List<Post>> getPosts() async {
    PostRepository repository = PostRepository();
    return await repository.getUserPosts(userInfo!.uid);
  }

  Future<UserInfo> getAuthUserInfo() async {
    return await chatRepository.getUserInfo(AuthRepository().userID!);
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: userInfo);
  }

  void handleFollowUser() async {
    if(!isFollowing.value && !isLoading) {
      isLoading = true;
      await remoteDataSourceImpl.followUser(userId: userInfo.uid).then((value) { isFollowing.value = true; isLoading = false;});
    }
    else if(isFollowing.value && !isLoading)
    {
      isLoading = true;
      await remoteDataSourceImpl.unfollowUser(userId: userInfo.uid).then((value) {isFollowing.value = false; isLoading = false;}); 
    }
  }
  Future<UserInfo> init(dynamic arg) async {
    // cua minh phai get info
    if (arg == null) {
      return await getAuthUserInfo();
    }
    if (arg is UserInfo) {
      isFollowing.value = await remoteDataSourceImpl.isFollowing(userId: arg.uid);
      return arg; 
    } else {
      throw Exception('Arg ...');
    }
  }
}
