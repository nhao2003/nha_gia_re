import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/utils/map_utils.dart';
import 'package:nha_gia_re/modules/chat/widgets/MediaGrid.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/message.dart';

class MessageRow extends StatelessWidget {
  final Message message;
  final bool hasError;

  MessageRow(this.message, {Key? key, this.hasError = false}) : super(key: key);

  Widget _buildContent() {
    if (message.text?.trim().isNotEmpty ?? false) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMine ? AppColors.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text ?? "NULL",
          style: AppTextStyles.roboto16regular,
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
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: MapUtils.getStaticMapUrl(message.location!, 10),
              ),
            ),
            const ListTile(
              title: Text("Vị trí của bạn"),
              subtitle: Text("Nhấn để xem vị trí trên bản đồ"),
            )
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
          mainAxisAlignment: message.isMine
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
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
                  GestureDetector(
                    child: _buildContent(),
                    onTap: () {
                      Get.toNamed(AppRoutes.map_picker_screen);
                    },
                  ),
                  const SizedBox(height: 4),
                  if (message.isMine && hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        "Lỗi khi gửi tin nhắn!",
                        style: AppTextStyles.roboto12regular
                            .copyWith(color: AppColors.red),
                      ),
                    ),
                  const SizedBox(height: 4),
                  if (message.images != null) MediaGrid(message.images!),
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

