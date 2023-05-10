import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class PersonalController extends GetxController{
  late UserInfo userInfo;
  var auth = AuthRepository();
  bool isYourSelf = false;
  late bool isFollowing = true;

  Future<List<Post>> getPosts() async
  {
    PostRepository repository = PostRepository();
    return await repository.getUserPosts(userInfo.uid);
  }
  void navToUserProfile()
  {
    Get.toNamed(AppRoutes.userProfile, arguments: userInfo);
  }
  void init(dynamic arg)
  {
    if(arg is UserInfo)
    {
      userInfo = arg;
      if(userInfo.uid == auth.userID)
      {
        isYourSelf = true;
      }
    }
    else
    {
      //throw Exception('Arg ...');
    }
  }
}




