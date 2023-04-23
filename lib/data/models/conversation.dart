import 'package:nha_gia_re/data/models/message.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Conversation {
  String id;
  String chatWithUser;

  Conversation({
    required this.id,
    required this.chatWithUser,
  });
  @override
  String toString() {
    return 'Conversation(id: $id, chatWithUser: $chatWithUser)';
  }
  factory Conversation.fromJson(Map<String, dynamic> json) {
    final uid = Supabase.instance.client.auth.currentUser!.id;
    return Conversation(
      id: json['id'],
      chatWithUser: json['user1_id'] == uid
          ? json['user2_info']
          : json['user1_info']
    );
  }
}
