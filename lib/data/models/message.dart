import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
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
  LatLng? location;
  MessageType type;

  Message({
    required this.id,
    required this.senderID,
    required this.text,
    required this.images,
    required this.postID,
    required this.sentAt,
    required this.isMine,
    required this.isRead,
    required this.type,
    required this.location,
  })  : assert(id.trim().isNotEmpty),
        assert(senderID.trim().isNotEmpty);

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
        isRead: json['is_receiver_read'],
        type: MessageType.parse(json['message_type']),
        location: json['location_message'] != null
            ? LatLng.fromJson(json['location_message'])
            : null);
  }

  @override
  String toString() {
    return 'Message(id: $id, senderID: $senderID, text: $text, images: $images, postId: $postID, sentAt: $sentAt, isRead: $isRead)';
  }
}
