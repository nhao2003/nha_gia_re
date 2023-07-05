import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/notification_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import 'package:badges/badges.dart' as badges;

class IconNotification extends StatelessWidget {
  const IconNotification({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationRepository notiRepo = GetIt.instance<NotificationRepository>();
    return FutureBuilder(
      future: notiRepo.getLengthNotificationsIsNotRead(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 28,
            ),
          );
        } else {
          if (snapshot.error != null) {
            return const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 28,
              ),
            );
          } else {
            return Obx(
              () => notiRepo.numNotificationsIsNotRead.value == 0
                  ? const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        size: 28,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 13, right: 13),
                      child: badges.Badge(
                        position:
                            badges.BadgePosition.topStart(top: -8, start: 18),
                        badgeContent: Text(
                          notiRepo.numNotificationsIsNotRead.value.toString(),
                          style: AppTextStyles.roboto11Bold,
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: AppColors.white,
                        ),
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          size: 28,
                        ),
                      ),
                    ),
            );
          }
        }
      },
    );
  }
}
