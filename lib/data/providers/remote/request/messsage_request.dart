import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class MessageRequest {
  String conservationId;
  String? content;
  String? postID;
  List<File>? images;

  MessageRequest({
    required this.conservationId,
    required this.content,
    this.postID,
    this.images,
  });

  Map<String, dynamic> toJson(List<String>? imageUrls) {
    return {
      'conversation_id': conservationId,
      'sender_id': Supabase.instance.client.auth.currentUser!.id,
      'message': content,
      'post_id': postID,
      'images': imageUrls,
    };
  }
}
