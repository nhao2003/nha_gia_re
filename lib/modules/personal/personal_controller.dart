import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/enums/enums.dart';
import '../../data/providers/remote/remote_data_source.dart';
import '../../data/providers/remote/request/filter_request.dart';
import '../../data/repositories/chat_repository.dart';

class PersonalController extends GetxController {
  late UserInfo userInfo;
  var auth = AuthRepository();
  var authId = AuthRepository().userID;
  late RxBool isFollowing = true.obs;
  bool isLoading = false;
  final remoteDataSourceImpl = RemoteDataSource();

  bool check()
  {
    return authId == userInfo.uid;
  }

  Future<List<Post>> getPosts() async {
    PostRepository repository = PostRepository();
    PostFilter filter = PostFilter(
      orderBy: OrderBy.priceAsc,
      postedBy: PostedBy.all,
      postedByUserID: userInfo.uid,
      from: 0,
      to: 10,
    );
    return await repository.getAllPosts(filter);
  }

  Future<UserInfo> getAuthUserInfo() async {
    return await auth.getUserInfo();
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
