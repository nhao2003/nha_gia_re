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
  final repo = ChatRepository();
  late final stream;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<UserMessage> dummy = const [];
    final ChatController _controller = Get.find<ChatController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  print('Xin chao');
                });
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text(
          AppStrings.chatScreenTitle,
          style: AppTextStyles.roboto20semiBold,
        ),
      ),
      body: StreamBuilder<dynamic>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return _emptyChatWidget();
            } else {
              final data = List<Map<String, dynamic>>.from(snapshot.data!)
                  .map((e) => Conversation.fromJson(e))
                  .toList();
              return SingleChildScrollView(
                child: Column(
                  children:
                      data.map((e) => UserMessage(conversation: e)).toList(),
                ),
              );
            }
          }),
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
          return const OnChattingScreen();
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
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10),
        child: Row(
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
                    conversation.chatWithUser.fullName ?? 'Unknown',
                    style: AppTextStyles.roboto16semiBold,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    conversation.messages.last.text,
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
              DateFormat('hh:mm').format(conversation.messages.last.sentAt),
              style:
                  AppTextStyles.roboto14regular.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
