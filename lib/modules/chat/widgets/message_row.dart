import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/utils/map_utils.dart';
import 'package:nha_gia_re/modules/chat/widgets/media_grid.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/message.dart';

class MessageRow extends StatelessWidget {
  final Message message;
  final Function(Message message)? onLocationMessageTap;
  final Function(Message message)? onTextMessageTap;

  const MessageRow(this.message,
      {Key? key, this.onLocationMessageTap, this.onTextMessageTap})
      : super(key: key);

  Widget _buildContent() {
    if (message.text?.trim().isNotEmpty ?? false) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMine ? AppColors.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: onTextMessageTap != null ? () => onTextMessageTap!(message) : null,
          child: Text(
            message.text ?? "NULL",
            style: AppTextStyles.roboto16regular,
          ),
        ),
      );
    }
    if (message.location != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: MapUtils.getStaticMapUrl(message.location!, 10),
              ),
            ),
            ListTile(
              title: const Text("Vị trí của bạn"),
              subtitle: const Text("Nhấn để xem vị trí trên bản đồ"),
              onTap: onLocationMessageTap != null ? () => onLocationMessageTap!(message) : null,
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment:
          message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(maxWidth: 75.0.wp),
              child: Column(
                crossAxisAlignment: message.isMine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContent(),
                  if (message.images != null) Column(
                    children: [
                      const SizedBox(height: 4),
                      MediaGrid(message.images!),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(message.sentAt),
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
