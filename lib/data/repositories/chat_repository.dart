import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/services/upload_avatar_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation.dart';
import '../providers/remote/request/messsage_request.dart';

class ChatRepository {
  final RemoteDataSource _remoteDataSource;
  final StreamController<List<Conversation>> _conversationStreamController =
  StreamController<List<Conversation>>.broadcast();
  ChatRepository(this._remoteDataSource);

  late StreamSubscription<List<Conversation>> conversationSubscription;
  final Map<String, UserInfo> _userInfos = {};
  late final Stream<List<Conversation>> stream;
  Stream<List<Conversation>> get conversationStream =>
      _remoteDataSource.getAllConversation();

  Future<UserInfo> getUserInfo(String uid) async {

    UserInfo? user = _userInfos[uid];
    if (user != null) return user;
    try {
      final data = await _remoteDataSource.getUserInfo(uid);
      user = UserInfo.fromJson(data);
      _userInfos.putIfAbsent(user.uid, () => user!);
      return UserInfo.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future sendMessage(MessageRequest request) async {
    List<String>? urls;
    if (request.images?.isNotEmpty != null) {
      urls = await uploadMessageMedia(
          List<File>.from(request.images!), request.conservationId);
    }
    await _remoteDataSource.sendMessage(request.toJson(urls));
  }

  Stream<List<Message>> getMessages(Conversation conversation) {
    return _remoteDataSource.getMessages(conversation);
  }

  Future<void> markMessagesRead(String conversationId) async {
    await _remoteDataSource.markMessagesRead(conversationId);
  }

  Future<Conversation> getOrCreateConversation(String uid) async {
    final data = await _remoteDataSource.getOrCreateConversation(uid);
    return Conversation.fromJson(data);
  }

  Future deleteConversation(String conversationID) async {
    await _remoteDataSource.deleteConversation(conversationID);
  }
}
