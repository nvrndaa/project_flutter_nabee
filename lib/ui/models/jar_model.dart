class JarModel {
  static final List<JarModel> jars = [];

  final String name;
  final String startDate;
  final String endDate;
  final String price;
  final String notification;

  JarModel({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.notification,
  });
}