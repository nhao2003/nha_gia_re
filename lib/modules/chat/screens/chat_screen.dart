import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/modules/chat/chat_controller.dart';
import 'package:nha_gia_re/modules/chat/screens/picked_media.dart';
import 'package:nha_gia_re/modules/chat/widgets/message_row.dart';
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
  bool isTyping = false;
  final ChatController _controller = Get.find<ChatController>();

  @override
  void initState() {
    _controller.initializeMessages(Get.arguments);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.onClose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() => Text(_controller.mediaPicker.value.length.toString())),
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
              List<Message> messages = snapshot.data ?? [];
              print("Snapshot: " + messages.length.toString());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Obx(
                    ()=> SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        _controller.mediaPicker.value.length, (index) {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _controller.mediaPicker.value[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                onPressed: () {
                                  _controller.removeMedia(_controller.mediaPicker.value[index]);
                                },
                                splashRadius: 14,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      );
                      }),
                    ),
                    )
                  ),
                  StreamBuilder<bool>(
                      stream: _controller.isAllowSendMessage,
                      builder: (context, snapshot) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            children: [
                              if (!isTyping)
                                IconButton(
                                    onPressed: _controller.takeAPhoto,
                                    icon: const Icon(Icons.camera_alt_sharp)),
                              if (!isTyping)
                                IconButton(
                                    onPressed: _controller.pickMedias,
                                    icon: const Icon(Icons.image)),
                              if (!isTyping)
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.pin_drop)),
                              Expanded(
                                child: TextField(
                                  controller: _controller.textEditingController,
                                  style: AppTextStyles.roboto16regular,
                                  maxLines: null,
                                  focusNode: focusNode,
                                  onTap: () {
                                    setState(() {
                                      isTyping = _controller
                                          .textEditingController
                                          .text
                                          .isNotEmpty;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      isTyping = value.isNotEmpty;
                                    });
                                  },
                                  onTapOutside: (e) {
                                    setState(() {
                                      isTyping = false;
                                      focusNode.unfocus();
                                    });
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
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)))),
                                ),
                              ),
                            ],
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
