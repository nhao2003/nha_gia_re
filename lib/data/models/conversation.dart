import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Conversation {
  String id;
  UserInfo chatWithUser;
  List<Message> messages;

  Conversation({
    required this.id,
    required this.chatWithUser,
    required this.messages,
  });
  @override
  String toString() {
    return 'Conversation(id: $id, chatWithUser: $chatWithUser, messages: $messages)';
  }
  factory Conversation.fromJson(Map<String, dynamic> json) {
    final uid = Supabase.instance.client.auth.currentUser!.id;
    return Conversation(
      id: json['id'],
      chatWithUser: json['user1_id'] == uid
          ? UserInfo.fromJson(json['user2_info'])
          : UserInfo.fromJson(json['user1_info']),
      messages: List<Message>.from(json['messages']
          .map(
            (e) => Message.fromJson(e),
      )
          .toList()), // Since it's not possible to deserialize a Stream, we'll set it to null here
    );
  }
}
