import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/modules/chat/chat_controller.dart';
import 'package:nha_gia_re/modules/conversations/widgets/message_row.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/text_styles.dart';

class ChatScreen extends StatefulWidget {
  late Conversation conversation;
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode focusNode = FocusNode();
  final ChatController _controller = Get.find<ChatController>();
  @override
  void initState() {
    _controller.initializeMessages(Get.arguments);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Chat Screen"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder<List<Message>>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Message> messages = snapshot.data!;
              print("Snapshot: " + messages.length.toString());
              return Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          //print("index: $index");
                          return MessageRow(
                            key: UniqueKey(),
                            messages[index],
                          );
                        },
                      ),
                    ),
                  ),
                  StreamBuilder<bool>(
                      stream: _controller.isAllowSendMessage,
                      builder: (context, snapshot) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: TextField(
                            controller: _controller.textEditingController,
                            style: AppTextStyles.roboto16regular,
                            maxLines: null,
                            //focusNode: focusNode,
                            onTap: () {},
                            onTapOutside: (e) {
                              focusNode.unfocus();
                            },

                            decoration: InputDecoration(
                                hintText: "Type a message",
                                suffixIcon: IconButton(
                                  onPressed: snapshot.data ?? true
                                      ? () async {
                                          await _controller.sendMessage();
                                        }
                                      : null,
                                  icon: const Icon(Icons.send),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)))),
                          ),
                        );
                      })
                ],
              );
            }
          }),
    );
  }
}
