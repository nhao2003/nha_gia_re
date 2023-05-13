import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/repositories/chat_repository.dart';

class PersonalController extends GetxController {
  UserInfo? userInfo;
  var auth = AuthRepository();
  bool isYourSelf = false;
  late bool isFollowing = true;
  ChatRepository chatRepository = ChatRepository();

  Future<List<Post>> getPosts() async {
    PostRepository repository = PostRepository();
    return await repository.getUserPosts(userInfo!.uid);
  }

  PersonalController() {
    getAuthUserInfo();
  }

  @override
  void onInit() {
    super.onInit();
    getAuthUserInfo();
  }

  Future<void> getAuthUserInfo() async {
    userInfo = await chatRepository.getUserInfo(AuthRepository().userID!);
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: userInfo);
  }

  void init(dynamic arg) async {
    if (arg == null) {
      await getAuthUserInfo();
    }
    if (arg is UserInfo) {
      userInfo = arg;
      if (userInfo!.uid == auth.userID) {
        isYourSelf = true;
      }
    } else {
      //throw Exception('Arg ...');
    }
  }
}
