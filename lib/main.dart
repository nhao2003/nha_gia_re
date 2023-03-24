import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nha_gia_re/routers/app_pages.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import 'core/values/app_strings.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  initializeDateFormatting();

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
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.workSans(),
        ),
      ),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
