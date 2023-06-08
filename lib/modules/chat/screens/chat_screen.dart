import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/modules/chat/chat_controller.dart';
import 'package:nha_gia_re/modules/chat/widgets/message_row.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

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
    super.initState();
    _controller.initializeMessages(Get.arguments);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.onClose();
    focusNode.dispose();
  }
  Widget _buildMessageList(List<Message> messages) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: MessageRow(
              key: UniqueKey(),
              messages[index],
            ),
          );
        },
      ),
    );
  }
  Widget _buildMediaPicker() {
    return Obx(() => SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(_controller.mediaPicker.length, (index) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 5),
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _controller.mediaPicker[index],
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
                      _controller.removeMedia(
                          _controller.mediaPicker.value[index]);
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
                    child: Text("Xoá tất cả"))),
          )
        ],
      ),
    ));
  }
  Widget _buildTextField(bool isTyping, bool? isEnable) {
    return Expanded(
      child: TextField(
        controller: _controller.textEditingController,
        style: AppTextStyles.roboto16regular,
        maxLines: null,
        focusNode: focusNode,
        onTap: () {
          setState(() {
            isTyping =
                _controller.textEditingController.text.isNotEmpty;
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
                borderRadius: BorderRadius.all(Radius.circular(25)))),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMessageList(messages),
                  if (_controller.mediaPicker.isNotEmpty)
                    _buildMediaPicker(),
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
                                    onPressed: _controller.sendLocation,
                                    icon: const Icon(Icons.pin_drop)),
                              _buildTextField(isTyping, snapshot.data),
                            ],
                          ),
                        );
                      }),
                ],
              );
            }
          }),
    );
  }
}
