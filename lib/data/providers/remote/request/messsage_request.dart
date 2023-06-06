import 'dart:io';

import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageRequest {
  String conservationId;
  String? content;
  String? postID;
  List<File>? images;
  late MessageType type;
  Address? location;
  MessageRequest({
    required this.conservationId,
    required this.content,
    this.postID,
    this.images,
    this.location,
  }) : assert(
          (postID == null && images == null && location == null) ||
              (postID != null && images == null && location == null) ||
              (postID == null && images != null && location == null) ||
              (postID == null && images == null && location != null),
          'Exactly one of postID, images, or location should be non-null.',
        ) {
    if (postID != null) {
      type = MessageType.post;
    } else if (images != null) {
      type = MessageType.images;
    } else if (location != null) {
      type = MessageType.location;
    } else {
      type = MessageType.text;
    }
  }

  Map<String, dynamic> toJson(List<String>? imageUrls) {
    return {
      'conversation_id': conservationId,
      'sender_id': Supabase.instance.client.auth.currentUser!.id,
      'message': content?.isNotEmpty != null ? content : null,
      'post_id': postID,
      'images': imageUrls,
      'message_type': type.toString(),
    };
  }
}
