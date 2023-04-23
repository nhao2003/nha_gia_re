import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/conversation.dart';
import '../providers/remote/request/messsage_request.dart';

class ChatRepository {
  final remoteDataSourceImpl = RemoteDataSourceImpl();
  List<UserInfo> _userInfos = [];

  Future<UserInfo> getUserInfo(String uid) async {
    final user = _userInfos.firstWhereOrNull((element) => element.uid == uid);
    if (user != null) return user;
    final data = await remoteDataSourceImpl.getUserInfo(uid);
    return UserInfo.fromJson(data);
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
    await remoteDataSourceImpl.sendMessage(request.toJson());
  }
}
