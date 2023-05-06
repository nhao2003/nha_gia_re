import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/home/screens/home_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/values/assets_image.dart';
import '../post/screens/post_screen.dart';
import 'package:nha_gia_re/modules/post_management/screens/post_management_screen.dart';
import 'tab_controller.dart';

class TabScreen extends StatelessWidget {
  final controller = Get.put(TabNavController());

  List<Widget> _pages = [];
  List<TabItem<dynamic>> _tab = [];

  @override
  Widget build(BuildContext context) {
    _pages = [
      const HomeScreen(),
      const PostManagementScreen(),
      const Scaffold(),
      const Scaffold(),
      const Scaffold(),
    ];
    _tab = [
      TabItem(
        icon: Image.asset(Assets.home),
        activeIcon: Image.asset(Assets.home, color: AppColors.primaryColor),
        title: 'Trang chủ',
      ),
      TabItem(
        icon: Image.asset(Assets.post),
        activeIcon: Image.asset(Assets.post, color: AppColors.primaryColor),
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
        activeIcon: Image.asset(Assets.bell, color: AppColors.primaryColor),
        title: 'Thông báo',
      ),
      TabItem(
        icon: Image.asset(Assets.person),
        activeIcon: Image.asset(Assets.person, color: AppColors.primaryColor),
        title: 'Tài khoản',
      ),
    ];
    return GetBuilder<TabNavController>(
      builder: (_) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: _pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: controller.changeTabIndex,
            backgroundColor: AppColors.white,
            color: AppColors.black,
            activeColor: AppColors.primaryColor,
            style: TabStyle.fixedCircle,
            curveSize: 75,
            top: -22,
            height: 55,
            items: _tab,
          ),
        );
      },
    );
  }
}
