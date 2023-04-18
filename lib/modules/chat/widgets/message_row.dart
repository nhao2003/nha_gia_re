import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

import '../../../core/theme/app_colors.dart';
import '../screens/onChattingScreen.dart';

class MessageRow extends StatelessWidget {
  Message message;
  bool isError;
  MessageRow(this.message, {Key? key, this.isError = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderID == "user1";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primaryColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                constraints: BoxConstraints(maxWidth: 75.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.content,
                      style: AppTextStyles.roboto16regular,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('HH:mm').format(message.time),
                      style: TextStyle(fontSize: 12, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isMe && isError) Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text("Lỗi khi gửi tin nhắn!", style: AppTextStyles.roboto12regular.copyWith(color: AppColors.red),),
          )
        ],
      ),
    );
  }
}
