import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class SplashController extends GetxController {
  final AuthRepository _authRepository = GetIt.instance<AuthRepository>();
  Future<void> init() async {
    await Future.delayed(Duration.zero);
    if (_authRepository.isUserLoggedIn) {
      Get.offAllNamed(AppRoutes.tabScreen);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
