import 'package:supabase_flutter/supabase_flutter.dart';

class Conversation {
  String id;
  String chatWithUser;
  String? lastMessage;
  DateTime lastMessageSentAt;

  Conversation({
    required this.id,
    required this.chatWithUser,
    required this.lastMessage,
    required this.lastMessageSentAt,
  }) : assert(id.isNotEmpty && chatWithUser.isNotEmpty);

  @override
  String toString() {
    return 'Conversation(id: $id, chatWithUser: $chatWithUser)';
  }

  Conversation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chatWithUser =
            json['user1_id'] == Supabase.instance.client.auth.currentUser!.id
                ? json['user2_id']
                : json['user1_id'],
        lastMessage = json['last_message'],
        lastMessageSentAt = DateTime.parse(json['last_message_sent_at']);
}
