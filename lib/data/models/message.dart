import 'package:supabase_flutter/supabase_flutter.dart';

class Message {
  String id;
  String senderID;
  String text;
  DateTime sentAt;
  bool isMine;

  Message({
    required this.id,
    required this.senderID,
    required this.text,
    required this.sentAt,
    required this.isMine,
  })  : assert(id.trim().isNotEmpty),
        assert(senderID.trim().isNotEmpty),
        assert(text.trim().isNotEmpty);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        senderID: json['sender_id'],
        text: json['message'],
        sentAt: DateTime.parse(json['sent_at']),
        isMine:
            Supabase.instance.client.auth.currentUser!.id == json['sender_id']);
  }
  @override
  String toString() {
    return 'Message(id: $id, senderID: $senderID, text: $text, sentAt: $sentAt)';
  }
}
