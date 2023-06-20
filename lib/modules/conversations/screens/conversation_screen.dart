import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/modules/chat/screens/chat_screen.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../../core/values/app_strings.dart';
import '../conversation_controller.dart';
import '../widgets/conversation_row.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late ConversationController _chatController;


  @override
  void initState() {
    _chatController = Get.find<ConversationController>();
    _chatController.initializeConversations();
    super.initState();
  }

  @override
  void dispose() {
    _chatController.close();
    super.dispose();
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
          stream: _chatController.conversationStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final List<Conversation> data = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List<FutureBuilder<UserInfo>>.from(data
                      .map((e) => FutureBuilder(
                          future: _chatController.getUserInfo(e.chatWithUser),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ConversationRow(
                                key: UniqueKey(),
                                conversation: e,
                                userInfo: snapshot.data!,
                                onTap: () {
                                  Get.toNamed(AppRoutes.chat, arguments: e);
                                },
                                onLongPress: () {
                                  Get.dialog(Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () => _chatController.markRead(e),
                                          child: Text(
                                            "Đánh dấu đã đọc",
                                            style: AppTextStyles.roboto16regular
                                                .copyWith(
                                                    color: AppColors.black),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => _chatController.deleteConversation(e),
                                          child: Text(
                                            "Xoá tin nhắn",
                                            style: AppTextStyles.roboto16regular
                                                .copyWith(
                                                    color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }))
                      .toList()),
                ),
              );
            } else {
              print("No data");
              return _emptyChatWidget();
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
