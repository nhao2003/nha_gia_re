import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:nha_gia_re/modules/personal/screens/setting_screen.dart';
import '../../core/theme/app_colors.dart';
import '../personal/screens/personal_screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  final myTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black,
  );

  void openHiddenDrawerController() {
    print('you press open');
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Tài khoản',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: AppColors.gery2,
        ),
        const PersonalScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Cài đặt',
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
          colorLineSelected: AppColors.gery2,
        ),
        const SettingScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      typeOpen: TypeOpen.FROM_RIGHT,
      backgroundColorAppBar: AppColors.primaryColor,
      elevationAppBar: 0,
      backgroundColorMenu: AppColors.primaryColor,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 60, // chieu rong cua drawer
      contentCornerRadius: 20, // bo goc page
      //disableAppBarDefault: true,
      //withAutoTittleName: false,
      //tittleAppBar: const Text("Tài khoản"),
      leadingAppBar: Icon(
        Icons.menu_outlined,
        color: AppColors.black,
      ),
    );
  }
}
