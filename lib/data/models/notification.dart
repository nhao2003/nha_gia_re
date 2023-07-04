import '../enums/enums.dart';

class NotificationModel {
  String id;
  NotificationType type;
  DateTime createAt;
  bool isRead;
  String title;
  String content;
  String? image;
  String? link;

  NotificationModel({
    required this.id,
    required this.type,
    required this.isRead,
    required this.createAt,
    required this.title,
    required this.content,
    this.image,
    this.link,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: NotificationType.parse(json['type']),
      createAt: DateTime.parse(json['create_at']),
      isRead: json['is_read'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      link: json['link'],
    );
  }
}
