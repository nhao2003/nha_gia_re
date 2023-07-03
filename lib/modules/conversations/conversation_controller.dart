import 'dart:async';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/conversation.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationController extends GetxController {
  late final ChatRepository repo;
  late final UserRepository userRepo;
  final supabase = Supabase.instance.client;

  Stream<List<Conversation>> get conversationStream => repo.conversationStream;
  final StreamController _streamController =
      StreamController<List<Conversation>>();
  late List<Conversation> conversations = [];



  Future<UserInfo> getUserInfo(String uid) async {
    try {
      return await userRepo.getUserInfo(uid);
    } catch (e) {
      rethrow;
    }
  }

  void initializeConversations() {
    repo = GetIt.instance<ChatRepository>();
    userRepo = GetIt.instance<UserRepository>();
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

  }

  void markRead(Conversation e) {
    repo.markMessagesRead(e.id);
    Get.back();
  }
}
