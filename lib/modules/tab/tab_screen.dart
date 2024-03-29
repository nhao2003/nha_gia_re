import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/blog/screens/blog_list_screen.dart';
import 'package:nha_gia_re/modules/home/screens/home_screen.dart';
import 'package:nha_gia_re/modules/settings/screens/settings_screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/values/assets_image.dart';
import 'package:nha_gia_re/modules/post_management/screens/post_management_screen.dart';
import '../personal/screens/personal_screen.dart';
import 'tab_controller.dart';

// ignore: must_be_immutable
class TabScreen extends StatefulWidget {

  TabScreen({super.key});
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with SingleTickerProviderStateMixin{
  List<Widget> _pages = [];
  List<TabItem<dynamic>> _tab = [];
  final controller = Get.put(TabNavController());
  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      PostManagementScreen(),
      const Scaffold(),
      const BlogListScreen(),
      const SettingsScreen(),
    ];
    _tab = [
      TabItem(
        icon: Image.asset(Assets.home),
        activeIcon: Image.asset(Assets.home, color: AppColors.primaryColor),
        title: 'Home'.tr,
      ),
      TabItem(
        icon: Image.asset(Assets.post),
        activeIcon: Image.asset(Assets.post, color: AppColors.primaryColor),
        title: 'Posts management'.tr,
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
        icon: const Icon(Icons.newspaper_outlined),
        activeIcon:
        Icon(Icons.newspaper_outlined, color: AppColors.primaryColor),
        title: 'Blog'.tr,
      ),
      TabItem(
        icon: Image.asset(Assets.person),
        activeIcon: Image.asset(Assets.person, color: AppColors.primaryColor),
        title: 'Account'.tr,
      ),
    ];
    controller.tabController = TabController(length: _tab.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<TabNavController>(
      builder: (_) {
        return Scaffold(
          body: TabBarView(
            controller: controller.tabController,
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
