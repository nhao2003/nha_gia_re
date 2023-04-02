import 'package:get/get.dart';
import 'package:nha_gia_re/modules/chat/chat_binding.dart';
import 'package:nha_gia_re/modules/chat/screens/chat_screen.dart';
import 'package:nha_gia_re/modules/login/screens/register_screen.dart';
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
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
  ];
}
