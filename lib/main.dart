import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/routers/app_pages.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/languages/localization_service.dart';
import 'core/values/app_strings.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'SUPABASE_URL',
    anonKey: 'SUPABASE_ANON_KEY',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // khong cho man hinh xoay ngang
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
          foregroundColor: AppColors.black,
          elevation: 0,
        ),
        primaryColor: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
