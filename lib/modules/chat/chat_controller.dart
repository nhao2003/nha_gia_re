import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/messsage_request.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/message.dart';

class ChatController extends GetxController {
  final repo = ChatRepository();
  final supabase = Supabase.instance.client;
  late StreamSubscription<List<Message>> streamSubscription;
  StreamController<List<Message>> _controller = StreamController();

  Stream<List<Message>> get stream => _controller.stream;
  late Conversation conversation;
  TextEditingController textEditingController = TextEditingController();
  final StreamController<bool> _allowSendingMessageController =
      StreamController();

  Stream<bool> get isAllowSendMessage => _allowSendingMessageController.stream;
  final ChatRepository _chatRepository = ChatRepository();
  Future<void> initializeMessages(dynamic arg) async {
    if (arg is Conversation) {
      conversation = arg;
    } else if (arg is UserInfo) {
      try {
        conversation = await repo.getOrCreateConversation(arg.uid);
        print('Goto chat by userInfo');
      } catch (e) {
        print(e.toString());
        rethrow;
      }
    } else {
      throw Exception("Invalid arg. Arg is UserInfo or Conversation");
    }
    streamSubscription =
        _chatRepository.getMessages(conversation.id).listen((event) {
      _controller.sink.add(event);
    });
  }

  Future<void> sendMessage() async {
    if (textEditingController.text.trim().isNotEmpty) {
      try {
        _allowSendingMessageController.sink.add(false);
        final txt = textEditingController.text;
        textEditingController.clear();
        await _chatRepository.sendMessage(MessageRequest(
            conservationId: conversation.id, content: txt.trim()));
      } catch (e) {
        print(e.toString());
        Get.snackbar(
          "Lỗi",
          "Đã xảy ra lỗi khi gửi tin nhắn. Vui lòng thử lại",
        );
      } finally {
        _allowSendingMessageController.sink.add(true);
      }
    }
  }

  Future close() async {
    streamSubscription.cancel();
  }
}
