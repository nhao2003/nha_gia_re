import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import '../../../core/values/app_strings.dart';
import '../chat_controller.dart';
import 'onChattingScreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<UserMessage> dummy = const [
      UserMessage(
        imagePath: Assets.avatar_1,
        name: 'John Smith',
        message: 'Hi, how are you?',
        time: '10:23 AM',
        isRead: true,
      ),
      UserMessage(
        imagePath: Assets.avatar_2,
        name: 'Jane Doe',
        message: 'I am doing well, thank you!',
        time: '11:45 AM',
      ),
      UserMessage(
        imagePath: Assets.avatar_3,
        name: 'Bob Johnson',
        message: 'What are you up to this weekend?',
        time: '1:34 PM',
      ),
      UserMessage(
        imagePath: Assets.avatar_4,
        name: 'Emily Jones',
        message: 'Hey there! How was your day? I miss you so much :((',
        time: '5:12 PM',
        isRead: true,
      ),
      UserMessage(
        imagePath: Assets.avatar_5,
        name: 'David Kim',
        message: 'Can you send me the report by tomorrow?',
        time: '9:07 AM',
      ),
      UserMessage(
        imagePath: Assets.avatar_16,
        name: 'Karen Lee',
        message: 'Did you hear about the new project?',
        time: '12:50 PM',
      ),
      UserMessage(
        imagePath: Assets.avatar_7,
        name: 'Tom Smith',
        message: 'I need your help with the presentation',
        time: '3:23 PM',
      ),
      UserMessage(
        imagePath: Assets.avatar_8,
        name: 'Amy Chen',
        message: 'What time is the meeting today?',
        time: '8:30 AM',
      ),
      UserMessage(
        imagePath: Assets.avatar_9,
        name: 'Mike Brown',
        message: 'Can we meet up for lunch tomorrow?',
        time: '11:56 AM',
      ),
      UserMessage(
        imagePath: Assets.avatar_10,
        name: 'Sara Patel',
        message: 'Are you free to chat now?',
        time: '2:15 PM',
      ),
      UserMessage(
        imagePath: Assets.avatar_11,
        name: 'Ryan Nguyen',
        message: 'Do you have any plans for the weekend?',
        time: '4:48 PM',
      ),
      UserMessage(
        imagePath: Assets.avatar_12,
        name: 'Lucas Hernandez',
        message: 'How was your trip?',
        time: '10:10 AM',
      ),
      UserMessage(
        imagePath: Assets.avatar_13,
        name: 'Mia Davis',
        message: 'Can you give me a call later?',
        time: '1:02 PM',
      ),
    ];
    final ChatController _controller = Get.find<ChatController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.chatScreenTitle,
          style: AppTextStyles.roboto20semiBold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: dummy,
        ),
      ),
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
  final String imagePath;
  final String name;
  final String message;
  final String time;
  final bool isRead;
  final EdgeInsetsGeometry? padding;

  const UserMessage({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.message,
    required this.time,
    this.padding,
    this.isRead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.secondary,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return OnChattingScreen();
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
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.roboto16semiBold,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
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
              time,
              style:
                  AppTextStyles.roboto14regular.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
