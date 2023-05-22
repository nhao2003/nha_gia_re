import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/data/models/conversation.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';
import '../../../data/models/user_info.dart';
import '../../../routers/app_routes.dart';

class ConversationRow extends StatelessWidget {
  final bool isRead;
  Conversation conversation;
  UserInfo userInfo;
  final EdgeInsetsGeometry? padding;

  ConversationRow({
    Key? key,
    required this.conversation,
    required this.userInfo,
    this.padding,
    this.isRead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.secondary,
      onTap: () {
        Get.toNamed(AppRoutes.chat, arguments: conversation);
      },
      onLongPress: () {
        Get.dialog(Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Đánh dấu đã đọc",
                  style: AppTextStyles.roboto16regular
                      .copyWith(color: AppColors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Xoá tin nhắn",
                  style: AppTextStyles.roboto16regular
                      .copyWith(color: AppColors.black),
                ),
              ),
            ],
          ),
        ));
      },
      child: Container(
        height: 100,
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userInfo.avatarUrl != null
                ? CircleAvatar(
              backgroundImage: NetworkImage(userInfo.avatarUrl!),
              radius: 30,
            )
                : const CircleAvatar(
              backgroundImage: AssetImage(Assets.avatar_2),
              radius: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userInfo.fullName!,
                    style: AppTextStyles.roboto16semiBold,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    conversation.lastMessage ?? "Start the conversation!",
                    style: isRead
                        ? AppTextStyles.roboto14semiBold
                        : AppTextStyles.roboto14regular
                        .copyWith(color: AppColors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              conversation.lastMessageSentAt.getTimeAgo(),
              style:
              AppTextStyles.roboto14regular.copyWith(color: AppColors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
