import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/chat/screens/chat_screen.dart';
import 'package:nha_gia_re/modules/home/screens/home_screen.dart';
import 'package:nha_gia_re/modules/personal/screens/personal_screen.dart';
import 'package:nha_gia_re/modules/post/screens/post_screen.dart';
import 'package:nha_gia_re/modules/search/screens/search_screen.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets_image.dart';
import '../dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                HomeScreen(),
                Scaffold(),
                MyCustomForm(),
                Scaffold(),
                PersonalScreen(),
              ],
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: AppColors.white,
            color: AppColors.black,
            activeColor: AppColors.primaryColor,
            style: TabStyle.fixedCircle,
            curveSize: 75,
            top: -22,
            height: 55,
            items: [
              TabItem(
                icon: Image.asset(Assets.home),
                activeIcon:
                    Image.asset(Assets.home, color: AppColors.primaryColor),
                title: 'Trang chủ',
              ),
              TabItem(
                icon: Image.asset(Assets.post),
                activeIcon:
                    Image.asset(Assets.post, color: AppColors.primaryColor),
                title: 'Quản lý tin',
              ),
              TabItem(
                icon: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Image.asset(
                    Assets.edit,
                    width: 40,
                  ),
                ),
              ),
              TabItem(
                icon: Image.asset(Assets.bell),
                activeIcon:
                    Image.asset(Assets.bell, color: AppColors.primaryColor),
                title: 'Thông báo',
              ),
              TabItem(
                icon: Image.asset(Assets.person),
                activeIcon:
                    Image.asset(Assets.person, color: AppColors.primaryColor),
                title: 'Tài khoản',
              ),
            ],
            onTap: controller.changeTabIndex,
          )
        );
      },
    );
  }

}