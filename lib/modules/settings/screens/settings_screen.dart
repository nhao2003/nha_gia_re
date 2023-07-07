import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets_image.dart';
import '../../../routers/app_routes.dart';
import 'package:badges/badges.dart' as badges;

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
                  .where((conversation) => conversation.numOfUnReadMessage != 0)
                  .toList();
              RxInt unreadCount = unreadConversations.length.obs;

              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.conversation);
                },
                child: Obx(
                  () => unreadCount.value == 0
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(Assets.messCircle, width: 25),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 13, right: 13),
                          child: badges.Badge(
                            position: badges.BadgePosition.topStart(
                                top: -8, start: 18),
                            badgeContent: Text(
                              unreadCount.value.toString(),
                              style: AppTextStyles.roboto11Bold
                                  .copyWith(color: AppColors.white),
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: AppColors.red,
                            ),
                            child: Image.asset(Assets.messCircle, width: 25),
                          ),
                        ),
                ),
              );
            },
          ),
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
            leading: Icon(
              Icons.manage_accounts_outlined,
              color: AppColors.black,
            ),
          ),
          FutureBuilder<String>(
            future: _controller.checkUserIsWaiting(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: Text("error"),
                  );
                } else {
                  _controller.verifyRepo.checkResult = snapshot.data!;
                  if (_controller.verifyRepo.checkResult == "2") {
                    // duyet duoc roi
                    return Container();
                  } else {
                    return ListTile(
                      title: Text('Account verification'.tr),
                      onTap: () {
                        if (_controller.verifyRepo.checkResult == "0") {
                          //chua co
                          _controller.navToVerification().then((value) {
                            setState(() {});
                          });
                        } else if (_controller.verifyRepo.checkResult == "1") {
                          // dang cho duyet
                          _controller.navToWaitingVerification().then((value) {
                            setState(() {});
                          });
                        } else {
                          // tu choi
                          _controller.navToRejectVerification(snapshot.data!);
                        }
                      },
                      leading: Icon(
                        Icons.admin_panel_settings_outlined,
                        color: AppColors.black,
                      ),
                    );
                  }
                }
              }
            },
          ),
          ListTile(
            title: Text('Premium'.tr),
            onTap: _controller.navToPurchase,
            leading: Icon(
              Icons.wallet,
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
