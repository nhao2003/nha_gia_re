import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/repositories/chat_repository.dart';

class PersonalController extends GetxController {
  late UserInfo userInfo;
  var auth = AuthRepository();
  bool isYourSelf = false;
  late bool isFollowing = true;
  ChatRepository chatRepository = ChatRepository();

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

  Future<UserInfo> init(dynamic arg) async {
    // cua minh phai get info
    if (arg == null) {
      return await getAuthUserInfo();
    }
    if (arg is UserInfo) {
      if (arg.uid == auth.userID) {
        isYourSelf = true;
      }
      return arg;
    } else {
      throw Exception('Arg ...');
    }
  }
}
