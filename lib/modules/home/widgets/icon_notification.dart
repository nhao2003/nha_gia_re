import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/notification_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class IconNotification extends StatelessWidget {
  const IconNotification({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationRepository notiRepo = GetIt.instance<NotificationRepository>();
    return Padding(
      padding: const EdgeInsets.only(top: 13, right: 13),
      child: Obx(
        () => notiRepo.listNotifications.isEmpty
            ? const Icon(
                Icons.notifications_none_outlined,
                size: 28,
              )
            : badges.Badge(
                position: badges.BadgePosition.topStart(top: -8, start: 18),
                badgeContent: Text(
                  notiRepo.listNotifications.length.toString(),
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
