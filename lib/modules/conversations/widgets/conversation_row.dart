import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';
import '../../../data/models/user_info.dart';

class ConversationRow extends StatelessWidget {
  final bool isRead;
  Conversation conversation;
  UserInfo userInfo;
  Function()? onTap, onLongPress;
  final EdgeInsetsGeometry? padding;

  ConversationRow({
    Key? key,
    required this.conversation,
    required this.userInfo,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.isRead = false,
  }) : super(key: key);

  String _getLastMessage() {
    if (conversation.lastMessageType == null)
      return "Start the conversation Null!";
    else if (conversation.lastMessageType == MessageType.text) {
      return conversation.lastMessage ?? "Start the conversation!";
    } else if (conversation.lastMessageType == MessageType.images) {
      return "${userInfo.fullName} has sent image to you.";
    } else if (conversation.lastMessageType == MessageType.location) {
      return "${userInfo.fullName} has sent a location to you.";
    } else if (conversation.lastMessageType == MessageType.post) {
      return "${userInfo.fullName} has sent a post to you.";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      contentPadding: const EdgeInsets.all(10),
      leading: userInfo.avatarUrl != null
          ? CircleAvatar(
        backgroundImage:
        CachedNetworkImageProvider(userInfo.avatarUrl!),
        radius: 30,
      )
          : const CircleAvatar(
        backgroundImage: AssetImage(Assets.avatar_2),
        radius: 30,
      ),
      title: Text(
        userInfo.fullName!,
        style: AppTextStyles.roboto16semiBold,
        maxLines: 1,
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Text(
          _getLastMessage(),
          style: conversation.numOfUnReadMessage != 0
              ? AppTextStyles.roboto14semiBold.copyWith(color: AppColors.black)
              : AppTextStyles.roboto14regular
              .copyWith(color: AppColors.grey),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Text(
        conversation.lastMessageSentAt.getTimeAgo(),
        style:
        AppTextStyles.roboto14regular.copyWith(color: AppColors.grey),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
