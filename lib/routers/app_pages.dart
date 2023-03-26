import 'package:get/get.dart';
import 'package:nha_gia_re/modules/search/screens/search_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/screens/home_screen.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/screens/login_screen.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => SearchScreen(),
      binding: LoginBinding(),
    ),
  ];
}
