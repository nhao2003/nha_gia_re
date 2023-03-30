class Message {
  String id;
  String senderID;
  String text;
  DateTime sentAt;
  Message({
    required this.id,
    required this.senderID,
    required this.text,
    required this.sentAt,
  })  : assert(id.trim().isNotEmpty),
        assert(senderID.trim().isNotEmpty),
        assert(text.trim().isNotEmpty);
}
