import 'package:supabase_flutter/supabase_flutter.dart';

class MessageRequest {
  String conservationId;
  String content;

  MessageRequest({required this.conservationId, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conservationId,
      'sender_id': Supabase.instance.client.auth.currentUser!.id,
      'message': content,
    };
  }
}
