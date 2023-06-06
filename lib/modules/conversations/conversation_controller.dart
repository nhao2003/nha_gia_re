import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationController extends GetxController {
  final repo = ChatRepository();
  final supabase = Supabase.instance.client;

  Stream get conversationStream => _streamController.stream;
  late StreamSubscription<List<Map<String, dynamic>>> streamSubscription;
  final StreamController _streamController =
      StreamController<List<Conversation>>();
  late List<Conversation> conversations;

  Future<UserInfo> getUserInfo(String uid) async {
    try {
      return await repo.getUserInfo(uid);
    } catch (e) {
      rethrow;
    }
  }

  void initializeConversations() {
    String uid = supabase.auth.currentUser!.id;
    streamSubscription = supabase
        .from('conversations')
        .stream(primaryKey: ['id']).listen((event) {
      conversations = [];
      for (var element in event) {
        if ((element['user1_id'] == uid &&
                DateTime.tryParse(element['user1_joined_at'].toString()) !=
                    null) ||
            (element['user2_id'] == uid &&
                DateTime.tryParse(element['user2_joined_at'].toString()) !=
                    null)) {
          conversations.add(Conversation.fromJson(element));
        }
      }
      _streamController.sink.add(conversations);
    });
  }

  Future deleteConversation(Conversation conversation) async {
    conversations.remove(conversation);
    _streamController.sink.add(conversations);
    await repo.deleteConversation(conversation.id).onError((error, stackTrace) {
      conversations.add(conversation);
      _streamController.sink.add(conversations);
    });
    Get.back();
  }

  Future<void> close() async {
    await streamSubscription.cancel();
  }
}
