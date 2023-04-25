import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/values/app_strings.dart';
import '../../../data/repositories/chat_repository.dart';
import '../chat_controller.dart';
import 'onChattingScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatController _chatController;
  @override
  initState() {
    _chatController = Get.find<ChatController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  print('Xin chao');
                });
              },
              icon: const Icon(Icons.refresh))
        ],
        title: Text(
          AppStrings.chatScreenTitle,
          style: AppTextStyles.roboto20semiBold,
        ),
      ),
      body: StreamBuilder(
          stream: _chatController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.length != 0) {
              print("Screen: ${snapshot.data}");
              final data = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<UserMessage>.from(
                      data.map((e) => UserMessage(conversation: e)).toList()),
                ),
              );
            } else {
              print("No data");
              return _emptyChatWidget();
            }
          }),
    );
  }

  _hasDataWidget() {
    return Center(
      child: Text("Has Data"),
    );
  }

  _emptyChatWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.emptyChat,
            width: 288,
            height: 279,
          ),
          Text(
            AppStrings.emptyConversation,
            style: AppTextStyles.roboto16regular.copyWith(
              color: AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final bool isRead;
  Conversation conversation;
  final EdgeInsetsGeometry? padding;

  UserMessage({
    Key? key,
    required this.conversation,
    this.padding,
    this.isRead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.secondary,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OnChattingScreen(conversation);
        }));
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
            const CircleAvatar(
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
                    conversation.chatWithUser,
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
              '2m',
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
