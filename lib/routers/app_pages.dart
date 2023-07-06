import 'package:get/get.dart';
import 'package:nha_gia_re/modules/admin_post_detail/admin_post_detail_binding.dart';
import 'package:nha_gia_re/modules/admin_post_detail/screens/admin_post_detail_screen.dart';
import 'package:nha_gia_re/modules/admin_post_manage/admin_post_binding.dart';
import 'package:nha_gia_re/modules/admin_post_manage/screens/admin_post_screen.dart';
import 'package:nha_gia_re/modules/address_form/address_binding.dart';
import 'package:nha_gia_re/modules/address_form/screens/address.dart';
import 'package:nha_gia_re/modules/blog/screens/blog_detail_screen.dart';
import 'package:nha_gia_re/modules/blog/screens/blog_list_screen.dart';
import 'package:nha_gia_re/modules/maps/screens/map_picker_screen.dart';
import 'package:nha_gia_re/modules/maps/screens/map_screen.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_binding.dart';
import 'package:nha_gia_re/modules/post_details/screen/post_details_screen.dart';
import 'package:nha_gia_re/modules/notification/notification_binding.dart';
import 'package:nha_gia_re/modules/notification/screens/notification_screen.dart';
import 'package:nha_gia_re/modules/purchase/purchase_binding.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_screens.dart';
import 'package:nha_gia_re/modules/search/screens/result_arg_screen.dart';
import 'package:nha_gia_re/modules/settings/screens/change_language.dart';
import 'package:nha_gia_re/modules/settings/screens/change_pass.dart';
import 'package:nha_gia_re/modules/settings/settings_binding.dart';
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
import '../modules/blog/blog_binding.dart';
import '../modules/conversations/conversation_binding.dart';
import '../modules/conversations/screens/conversation_screen.dart';
import 'package:nha_gia_re/modules/user_profile/screens/user_profile_screen.dart';
import 'package:nha_gia_re/modules/user_profile/user_profile_binding.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/screens/home_screen.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/screens/login_screen.dart';
import '../modules/login/screens/register_screen.dart';
import '../modules/maps/map_binding.dart';
import '../modules/personal/personal_binding.dart';
import '../modules/personal/screens/personal_screen.dart';
import '../modules/post/post_binding.dart';
import '../modules/post/screens/post_screen.dart';
import '../modules/search/search_binding.dart';
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
      page: () => const ChatScreen(),
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
      page: () => const PostScreen(),
      binding: PostBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => FilterScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.personal,
      page: () => const PersonalScreen(),
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
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.map_view_screen,
      page: () => MapViewScreen(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: AppRoutes.map_picker_screen,
      page: () => MapPickerScreen(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: AppRoutes.resultArg,
      page: () => ResultArgScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.blog_screen,
      page: () => const BlogListScreen(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: AppRoutes.blog_screen_detail,
      page: () => const BlogDetailScreen(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: AppRoutes.address,
      page: () => const AddressScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes.admin_post,
      page: () => AdminPostScreen(),
      binding: AdminPostBinding(),
    ),
    GetPage(
      name: AppRoutes.admin_post_detail,
      page: () => const AdminPostDetailScreen(),
      binding: AdminPostDetailBinding(),
    ),
    GetPage(name: AppRoutes.change_pass, page: () => ChangePassScreen(), binding: SettingsBinding()),
    GetPage(name: AppRoutes.change_lang, page: () => ChangeLanguageScreen(), binding: SettingsBinding()),
    GetPage(
      name: AppRoutes.purchase_screen,
      page: () => const PurchaseScreen(),
      binding: PurchaseBinding(),
    ),
  ];
}
