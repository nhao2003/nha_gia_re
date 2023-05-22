import 'dart:io';

import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source_impl.dart';
import 'package:nha_gia_re/data/services/upload_avatar_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation.dart';
import '../providers/remote/request/messsage_request.dart';

class ChatRepository {
  final remoteDataSourceImpl = RemoteDataSourceImpl();
  final Map<String, UserInfo> _userInfos = {};

  Future<UserInfo> getUserInfo(String uid) async {
    UserInfo? user = _userInfos[uid];
    if (user != null) return user;
    try {
      final data = await remoteDataSourceImpl.getUserInfo(uid);
      user = UserInfo.fromJson(data);
      _userInfos.putIfAbsent(user.uid, () => user!);
      return UserInfo.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Conversation>> getAllConservations() async* {
    final Stream<List<Map<String, dynamic>>> res =
        remoteDataSourceImpl.getAllConversation();
    await for (var conversations in res) {
      List<Conversation> conversationList = [];
      for (var conversationJson in conversations) {
        conversationList.add(Conversation.fromJson(conversationJson));
      }
      yield conversationList;
    }
  }

  Future sendMessage(MessageRequest request) async {
    List<String>? urls;
    if(request.images != null || request.images!.isNotEmpty){
      print("OKKKK ${List<File>.from(request.images!)}");
      urls = await uploadMessageMedia(List<File>.from(request.images!), request.conservationId);
    }
    await remoteDataSourceImpl.sendMessage(request.toJson(urls));
  }

  Stream<List<Message>> getMessages(String conversationId) {
    return remoteDataSourceImpl.getMessages(conversationId);
  }

  Future<Conversation> getOrCreateConversation(String uid) async {
    final data = await remoteDataSourceImpl.getOrCreateConversation(uid);
    return Conversation.fromJson(data);
  }
}
