import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();
  Future<void> init() async {
    await Future.delayed(Duration.zero);
    UserRepository userRepo = GetIt.instance<UserRepository>();
    if (_authRepository.isUserLoggedIn) {
      UserInfo userInfo = await userRepo.getUserInfo();
      if (userInfo.updatedDate == null) {
        Get.offAllNamed(AppRoutes.userProfile);
      } else {
        Get.offAllNamed(AppRoutes.tabScreen);
      }
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
