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

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderID: json['sender_id'],
      text: json['message'],
      sentAt: DateTime.parse(json['sent_at']),
    );
  }
  @override
  String toString() {
    return 'Message(id: $id, senderID: $senderID, text: $text, sentAt: $sentAt)';
  }
}
