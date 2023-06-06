import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/chat/widgets/MediaGrid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/message.dart';

class MessageRow extends StatelessWidget {
  Message message;
  bool isError;

  MessageRow(this.message, {Key? key, this.isError = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        // Add SingleChildScrollView here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: message.isMine
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  constraints: BoxConstraints(maxWidth: 75.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.text?.trim().isNotEmpty??false)
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: message.isMine
                              ? AppColors.primaryColor
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message.text ?? "NULL",
                          style: AppTextStyles.roboto16regular,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (message.isMine && isError)
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
        ),
      ),
    );
  }

}
