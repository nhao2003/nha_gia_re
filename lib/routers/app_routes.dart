abstract class AppRoutes {
  // splashScreen
  static const splashScreen = '/splash';
  // tabScreens
  static const tabScreen = '/tab';
  // home route
  static const home = '/home';
  // login
  static const login = '/login';
  // address form
  static const address = '/address';
  // search
  static const search = '/search';
  static const filter = '/search/filter';
  static const resultArg = '/search/resultArg';

  static const post = '/post';
  static const dashboard = '/dashboard';
  static const personal = '/personal';
  //chat
  static const conversation = '/conversation';
  static const chat = '/chat';
  static const register = '/register';
  static const forgotPass = '/forgotPass';
  static const test = '/test';
  static const userProfile = '/user_profile';
  // post management
  static const postManagement = '/post_management';
  // noti
  static const notification = '/notification';
  static const post_detail = '/post_detail/:id';
  static const admin_post = '/admin_post';
  static const admin_post_detail = '/admin_post_detail';

  static const map_view_screen = '/map_view_screen';
  static const map_picker_screen = '/map_picker_screen';

  static const blog_screen = '/blog_screen';
  static const blog_screen_detail = '/blog_screen_detail';
  // setting
  static const change_pass = '/settings/changePass';
  static const change_lang = '/settings/changeLang';
  static const verification_card_screen = '/setting/verification_card';
  static const verification_portrait_screen = '/setting/verification_portrait';
  static const verification_info_screen = '/setting/verification_info';
  static String getPostRoute(String id) {
    return '/post_detail/$id';
  }

  static const purchase_screen = '/purchase_screen';
}
