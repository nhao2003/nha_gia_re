import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class SplashController extends GetxController {
  AuthRepository _authRepository = AuthRepository();
  Future<void> init() async {
    await Future.delayed(Duration.zero);
    if(_authRepository.isUserLoggedIn){
      Get.offAllNamed(AppRoutes.tabScreen);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
