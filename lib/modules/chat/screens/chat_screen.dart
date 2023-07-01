import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/global_widgets/media_page_view.dart';
import 'package:nha_gia_re/modules/chat/chat_controller.dart';
import 'package:nha_gia_re/modules/chat/widgets/message_row.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../../core/theme/text_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FocusNode focusNode = FocusNode();
  bool isTyping = false;
  late final ChatController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ChatController>();
    _controller.initializeMessages(Get.arguments);
  }

  @override
  void dispose() {
    _controller.onClose();
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildMessageList(List<Message> messages) {
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final currentMessage = messages[index];
          final currentDow = currentMessage.sentAt.weekday;

          bool showDayOfWeek = (index != 0 &&
                  index + 1 < messages.length &&
                  currentDow != messages[index + 1].sentAt.weekday) ||
              index == messages.length - 1;

          String dateFormat =
              DateFormat('dd/MM/yyyy').format(currentMessage.sentAt);
          final displayDate =
              (dateFormat == currentDate) ? 'Hôm nay' : currentMessage.sentAt.getTimeAgo();

          log("$index / ${messages.length} / ${messages[index].text}");

          return Column(
            children: [
              if (showDayOfWeek)
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    displayDate,
                    style: AppTextStyles.roboto10regular,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MessageRow(
                  isNewest: index == 0,
                  messages[index],
                  onLocationMessageTap: (message) {
                    Get.toNamed(AppRoutes.map_view_screen, arguments: message);
                  },
                  onMediaItemInMediaGridTap: (mess, index) {
                    Get.to(MediaPageView(
                      mess.images!,
                      defaultIndex: index,
                    ));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMediaPicker() {
    return Obx(
      () => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._controller.mediaPicker.map((media) {
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        media,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                      onPressed: () {
                        _controller.removeMedia(media);
                      },
                      splashRadius: 14,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: TextButton(
                  onPressed: _controller.mediaPicker.clear,
                  child: Text("Xoá tất cả"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(bool isTyping, bool? isEnable) {
    return Flexible(
      child: TextField(
        controller: _controller.textEditingController,
        style: AppTextStyles.roboto16regular,
        maxLines: 5,
        minLines: 1,
        focusNode: focusNode,
        onTap: () {
          setState(() {
            isTyping = _controller.textEditingController.text.isNotEmpty;
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
            onPressed: isEnable ?? true
                ? () async {
                    await _controller.sendMessage();
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
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
            final List<Message> messages = snapshot.data ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMessageList(messages),
                if (_controller.mediaPicker.isNotEmpty) _buildMediaPicker(),
                StreamBuilder<bool>(
                  stream: _controller.isAllowSendMessage,
                  builder: (context, snapshot) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          if (!isTyping)
                            IconButton(
                              onPressed: _controller.takeAPhoto,
                              icon: const Icon(Icons.camera_alt_sharp),
                            ),
                          if (!isTyping)
                            IconButton(
                              onPressed: _controller.pickMedias,
                              icon: const Icon(Icons.image),
                            ),
                          if (!isTyping)
                            IconButton(
                              onPressed: _controller.sendLocation,
                              icon: const Icon(Icons.pin_drop),
                            ),
                          _buildTextField(isTyping, snapshot.data),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
