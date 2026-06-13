class HoneyJarResponseModel {
  final int id;
  final int userId;
  final String jarName;
  final String targetAmount;
  final String currentAmount;
  final String deadline;
  final String status;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;

  HoneyJarResponseModel({
    required this.id,
    required this.userId,
    required this.jarName,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    required this.status,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HoneyJarResponseModel.fromMap(Map<String, dynamic> json) {
    return HoneyJarResponseModel(
      id: json['id'],
      userId: json['user_id'],
      jarName: json['jar_name'],
      targetAmount: json['target_amount'].toString(),
      currentAmount: json['current_amount'].toString(),
      deadline: json['deadline'],
      status: json['status'] ?? 'active',
      isCompleted: json['is_completed'] == true || json['is_completed'] == 1,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
