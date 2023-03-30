import 'package:nha_gia_re/data/models/message.dart';

class Conversation {
  String id;
  String chatWithUserHasID;
  List<Message> messages;
  Conversation(
      {required this.id,
      required this.chatWithUserHasID,
      required this.messages})
      : assert(chatWithUserHasID.isNotEmpty);
}
