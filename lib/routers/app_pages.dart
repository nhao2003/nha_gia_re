import 'package:get/get.dart';
import 'package:nha_gia_re/modules/dashboard/screens/dashboard_screen.dart';
import 'package:nha_gia_re/modules/search/screens/search_screen.dart';
import '../modules/chat/chat_binding.dart';
import '../modules/chat/screens/chat_screen.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/screens/home_screen.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/screens/login_screen.dart';
import '../modules/login/screens/register_screen.dart';
import '../modules/personal/personal_binding.dart';
import '../modules/personal/screens/personal_screen.dart';
import '../modules/post/post_binding.dart';
import '../modules/post/screens/post_screen.dart';
import '../modules/search/search_binding.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
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
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
      name: AppRoutes.post,
      page: () => const MyCustomForm(),
      binding: PostBinding(),
    ),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardPage(), binding: DashboardBinding()),
    GetPage(
      name: AppRoutes.personal,
      page: () => const PersonalScreen(),
      binding: PersonalBinding(),
    )
  ];
}
