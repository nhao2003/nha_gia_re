import 'package:get/get.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_binding.dart';
import 'package:nha_gia_re/modules/post_details/screen/post_details_screen.dart';
import 'package:nha_gia_re/modules/notification/notification_binding.dart';
import 'package:nha_gia_re/modules/notification/screens/notification_screen.dart';
import 'package:nha_gia_re/modules/splash/screens/spash_screen.dart';
import 'package:nha_gia_re/modules/splash/splash_binding.dart';
import 'package:nha_gia_re/modules/tab/tab_binding.dart';
import 'package:nha_gia_re/modules/tab/tab_screen.dart';
import 'package:nha_gia_re/modules/post_management/screens/post_management_screen.dart';
import 'package:nha_gia_re/modules/post_management/post_management_binding.dart';
import 'package:nha_gia_re/modules/search/screens/filter_screen.dart';
import 'package:nha_gia_re/modules/chat/chat_binding.dart';
import 'package:nha_gia_re/modules/chat/screens/chat_screen.dart';
import 'package:nha_gia_re/modules/search/screens/search_screen.dart';
import 'package:nha_gia_re/modules/test/screens/test.dart';
import '../modules/conversations/conversation_binding.dart';
import '../modules/conversations/screens/conversation_screen.dart';
import 'package:nha_gia_re/modules/user_profile/screens/user_profile_screen.dart';
import 'package:nha_gia_re/modules/user_profile/user_profile_binding.dart';
import '../modules/chat/chat_binding.dart';
import '../modules/chat/screens/chat_screen.dart';
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
import '../modules/test/test_binding.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.tabScreen,
      page: () => TabScreen(),
      binding: TabBinding(),
    ),
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
      name: AppRoutes.conversation,
      page: () => const ConversationScreen(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.post,
      page: () => const MyCustomForm(),
      binding: PostBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => FilterScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.test,
      page: () => const TestScreen(),
      binding: TestBinding(),
    ),
    GetPage(
      name: AppRoutes.personal,
      page: () => PersonalScreen(),
      binding: PersonalBinding(),
    ),
    GetPage(
        name: AppRoutes.userProfile,
        page: () => const UserProfileScreen(),
        binding: UserProfileBinding()),
    GetPage(
      name: AppRoutes.postManagement,
      page: () => PostManagementScreen(),
      binding: PostManagementBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.post_detail,
        page: () => const PostDetailsScreen(),
        binding: PostDetailBinding()),
  ];
}
