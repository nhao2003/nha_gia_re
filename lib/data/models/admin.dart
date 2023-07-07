import 'dart:convert';

class Admin {
  String id;
  DateTime? createdAt;
  String userId;
  Admin({
    required this.id,
    this.createdAt,
    required this.userId,
  });
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      userId: json['user_id'] as String,
    );
  }
}
