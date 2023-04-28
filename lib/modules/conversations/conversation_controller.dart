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
  late final Stream rawRoomsSubscription;
  Stream get conversationStream => _streamController.stream;
  late StreamSubscription<List<Map<String, dynamic>>> streamSubscription;
  final StreamController _streamController =
      StreamController<List<Conversation>>();
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
      print(event.toString());
      final conversation = event
          .where((element) =>
              element['user1_id'] == uid || element['user2_id'] == uid)
          .map((e) => Conversation.fromJson(e))
          .cast<Conversation>()
          .toList();
      _streamController.sink.add(conversation);
    });
  }

  Future<void> close() async {
    print("Delete stream");
    await streamSubscription.cancel();
  }
}
