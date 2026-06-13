import 'dart:convert';

class NotificationLogResponseModel {
  final int id;
  final int userId;
  final int reminderNumber;
  final String createdAt;
  final String updatedAt;

  NotificationLogResponseModel({
    required this.id,
    required this.userId,
    required this.reminderNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationLogResponseModel.fromJson(String str) =>
      NotificationLogResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationLogResponseModel.fromMap(Map<String, dynamic> json) =>
      NotificationLogResponseModel(
        id: json['id'],
        userId: json['user_id'],
        reminderNumber: json['reminder_number'],
        createdAt: json['created_at'] ?? '',
        updatedAt: json['updated_at'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'reminder_number': reminderNumber,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
