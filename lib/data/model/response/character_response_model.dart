import 'dart:convert';

class CharacterResponseModel {
  final int id;
  final int userId;
  final String name;
  final String type;
  final int xp;
  final String currentMood;
  final String? lastSavedDate;

  CharacterResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.xp,
    required this.currentMood,
    this.lastSavedDate,
  });

  factory CharacterResponseModel.fromJson(String str) =>
      CharacterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CharacterResponseModel.fromMap(Map<String, dynamic> json) =>
      CharacterResponseModel(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'] ?? '',
        type: json['type'] ?? 'Larva',
        xp: json['xp'] ?? 0,
        currentMood: json['current_mood'] ?? 'sedih',
        lastSavedDate: json['last_saved_date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'type': type,
        'xp': xp,
        'current_mood': currentMood,
        'last_saved_date': lastSavedDate,
      };
}
