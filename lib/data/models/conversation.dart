import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Conversation {
  String id;
  String chatWithUser;
  String? lastMessage;
  int numOfUnReadMessage;
  DateTime lastMessageSentAt;
  DateTime timeJoined;
  MessageType? lastMessageType;
  Conversation({
    required this.id,
    required this.chatWithUser,
    required this.lastMessage,
    required this.lastMessageSentAt,
    required this.numOfUnReadMessage,
    required this.timeJoined,
    required this.lastMessageType,
  }) : assert(id.isNotEmpty && chatWithUser.isNotEmpty);

  @override
  String toString() {
    return 'Conversation(id: $id, chatWithUser: $chatWithUser, timeJoined: $timeJoined)';
  }

  Conversation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chatWithUser =
            json['user1_id'] == Supabase.instance.client.auth.currentUser!.id
                ? json['user2_id']
                : json['user1_id'],
        numOfUnReadMessage =
            json['user1_id'] == Supabase.instance.client.auth.currentUser!.id
                ? json['num_of_unread_messages_of_user1']
                : json['num_of_unread_messages_of_user1'],
        lastMessage = json['last_message'],
        lastMessageSentAt = DateTime.parse(json['last_message_sent_at']),
        timeJoined =
            json['user1_id'] == Supabase.instance.client.auth.currentUser!.id
                ? DateTime.parse(json['user1_joined_at'])
                : DateTime.parse(json['user2_joined_at']),
        lastMessageType = json['last_message_type'] == null
            ? null
            : MessageType.parse(json['last_message_type']);
}
