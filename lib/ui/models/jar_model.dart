import 'package:flutter_nabee/data/model/response/honey_jar_response_model.dart';

class JarModel {
  final int? id;
  final String name;
  final String startDate;
  final String endDate;
  final String price;
  final String currentAmount;
  final bool isCompleted;
  final String notification;

  JarModel({
    this.id,
    required this.name,
    this.startDate = '',
    required this.endDate,
    required this.price,
    this.currentAmount = '0',
    this.isCompleted = false,
    this.notification = '3x',
  });

  factory JarModel.fromResponse(HoneyJarResponseModel r) {
    return JarModel(
      id: r.id,
      name: r.jarName,
      endDate: r.deadline,
      price: r.targetAmount,
      currentAmount: r.currentAmount,
      isCompleted: r.isCompleted,
    );
  }
}
