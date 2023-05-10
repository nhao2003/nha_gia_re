import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/properties/post.dart';
import '../../data/models/user_info.dart';

class PostDetailController extends GetxController {
  // code controller here
  // define variable and function
  late Post post;
  late UserInfo userInfo;
  void initArg(dynamic arg)
  {
    if(arg is Post)
    {
      post = arg;
    }
  }

  Future<List<dynamic>> init() async
  {
    ChatRepository repo = ChatRepository();
    PostRepository postRepo = PostRepository();
    final data = Future.wait([repo.getUserInfo(post.userID),postRepo.getPostDetail(post)]);
    return data;
  }

  void navToChat()
  {
    Get.toNamed(AppRoutes.chat, arguments: userInfo);
  }
  void navToUserProfile()
  {
    Get.toNamed(AppRoutes.personal);
  }
  void launchPhone()
  {
    launchUrl(Uri.parse("tel://${userInfo.phoneNumber}"));
  }
  void launchSms()
  {
    launchUrl(Uri.parse("sms://${userInfo.phoneNumber}"));
  }
}
