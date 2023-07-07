import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class TabNavController extends GetxController {
  int tabIndex = 0;

  void changeTabIndex(int index) async {
    if (index == 2) {
        Get.toNamed(AppRoutes.post);
    } else {
      tabIndex = index;
    }
    update();
  }
}
