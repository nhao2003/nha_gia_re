import 'dart:async';
import 'dart:io';
import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/services/upload_avatar_service.dart';
import '../models/conversation.dart';
import '../providers/remote/request/messsage_request.dart';

class ChatRepository {
  final RemoteDataSource _remoteDataSource;
  final StreamController<List<Conversation>> _conversationStreamController =
      StreamController<List<Conversation>>.broadcast();
  ChatRepository(this._remoteDataSource);

  late StreamSubscription<List<Conversation>> conversationSubscription;
  late final Stream<List<Conversation>> stream;
  Stream<List<Conversation>> get conversationStream =>
      _remoteDataSource.getAllConversation();

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
