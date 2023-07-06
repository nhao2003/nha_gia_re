import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';
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
        children: ListTile.divideTiles(context: context, tiles: [
          FutureBuilder(
              future: _controller.init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _controller.userInfo = snapshot.data!;
                  return ListTile(
                    title: Text(_controller.userInfo.fullName!),
                    onTap: _controller.navToPersonal,
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          _controller.userInfo.avatarUrl!),
                      radius: 20.0,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          ListTile(
            title: Text('Favorite'.tr),
            onTap: _controller.navToFavorite,
            leading: Icon(Icons.favorite, color: AppColors.red),
          ),
          ListTile(
            title: Text('Update information'.tr),
            onTap: _controller.navToUserProfile,
            leading: Image.asset(Assets.person, width: 24, height: 24),
          ),
          ListTile(
            title: Text('Account verification'.tr),
            onTap: _controller.navToVerification,
            leading: Icon(
              Icons.admin_panel_settings_outlined,
              color: AppColors.black,
            ),
          ),
          ListTile(
            title: Text('Change password'.tr),
            onTap: _controller.navToChangePass,
            leading: Icon(
              Icons.lock_outline_rounded,
              color: AppColors.black,
            ),
          ),
          ListTile(
            title: Text('Language'.tr),
            onTap: _controller.navToChangeLang,
            leading: Icon(
              Icons.language_outlined,
              color: AppColors.black,
            ),
          ),
          ListTile(
            title: Text('Sign out'.tr),
            onTap: _controller.handleSignOut,
            leading: Icon(
              Icons.logout,
              color: AppColors.black,
            ),
          ),
        ]).toList(),
      ),
    );
  }
}
