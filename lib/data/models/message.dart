import 'package:supabase_flutter/supabase_flutter.dart';

class Message {
  String id;
  String senderID;
  String? text;
  List<String>? images;
  String? postID;
  DateTime sentAt;
  bool isMine;
  bool isRead;

  Message({
    required this.id,
    required this.senderID,
    required this.text,
    required this.images,
    required this.postID,
    required this.sentAt,
    required this.isMine,
    required this.isRead,
  })  : assert(id.trim().isNotEmpty),
        assert(senderID.trim().isNotEmpty),
        assert(text == null || text.trim().isNotEmpty);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        senderID: json['sender_id'],
        text: json['message'],
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        postID: json['post_id'],
        sentAt: DateTime.parse(json['sent_at']),
        isMine:
            Supabase.instance.client.auth.currentUser!.id == json['sender_id'],
        isRead: json['is_receiver_read']);
  }

  @override
  String toString() {
    return 'Message(id: $id, senderID: $senderID, text: $text, images: $images, postId: $postID, sentAt: $sentAt, isRead: $isRead)';
  }
}
