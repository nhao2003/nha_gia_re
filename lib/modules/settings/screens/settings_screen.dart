import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';
import 'package:nha_gia_re/modules/settings/widget/settings_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets_image.dart';
import '../../../routers/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsController _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411, 683));
    return Scaffold(
        appBar: AppBar(
        title: Text('Settings'.tr),
        actions: [
          StreamBuilder(
              stream: GetIt.instance<ChatRepository>().conversationStream,
              builder: (context, snapShot) {
                final conversations = snapShot.data ?? [];
                final unreadConversations = conversations
                    .where(
                        (conversation) => conversation.numOfUnReadMessage != 0)
                    .toList();
                final unreadCount = unreadConversations.length;

                return IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.conversation);
                  },
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  constraints: const BoxConstraints(),
                  icon: Stack(
                    children: [
                      Image.asset(Assets.messCircle, width: 36),
                      if (unreadCount > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _controller.init(),
            builder: (context, snapshot) {
          if (snapshot.hasData) {
            _controller.userInfo = snapshot.data!;
            return SettingsItem(title: _controller.userInfo.fullName!, onPressed: _controller.navToPersonal, imageUrl: _controller.userInfo.avatarUrl,);
          }
          else
          {
            return Center(child: CircularProgressIndicator(),);
          }
          }),
          SettingsItem(title: 'Favorite'.tr, onPressed: _controller.navToFavorite, icon: Icon(Icons.favorite,color: AppColors.red,),),
          SettingsItem(title: 'Update information'.tr, onPressed: _controller.navToUserProfile, icon: Image.asset(Assets.person,width: 24,height: 24,),),
          SettingsItem(title: 'Change password'.tr, onPressed: _controller.navToChangePass, icon: const Icon(Icons.lock_outline_rounded,),),
          SettingsItem(title: 'Language'.tr, onPressed: _controller.navToChangeLang, icon: const Icon(Icons.language_outlined,),),
          SettingsItem(title: 'Sign out'.tr, onPressed: _controller.handleSignOut, icon: const Icon(Icons.logout,),),
        ],
      ),
    );
  }
}