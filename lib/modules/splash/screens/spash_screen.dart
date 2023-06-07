import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/splash/splash_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _controller = SplashController();
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:  Center(
        child: Text("Nhà Giá Rẻ", style: AppTextStyles.roboto20semiBold,),
      ),
    );
  }
}
