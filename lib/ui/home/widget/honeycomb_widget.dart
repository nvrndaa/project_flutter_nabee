import 'package:flutter/material.dart';

class HoneycombWidget extends StatelessWidget {
  final String dayText;
  final Color bgColor;
  final Color? textColor;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final bool hasAlert;

  const HoneycombWidget({
    super.key,
    required this.dayText,
    required this.bgColor,
    required this.width,
    required this.height,
    this.textColor,
    this.onTap,
    this.hasAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasAlert ? null : onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: HexagonPainter(
              color: bgColor,
              borderColor: hasAlert ? const Color(0xffFFAA2C) : null,
            ),
          ),
          if (!hasAlert)
            Text(
              dayText,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.32,
              ),
            ),
          if (hasAlert)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;
  final Color? borderColor;

  HexagonPainter({required this.color, this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final double cx = size.width / 2;

    path.moveTo(cx, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(cx, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();

    canvas.drawPath(path, paint);

    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- BUILDER BARIS GRID SARANG LEBAH ---
Widget buildHoneycombRow(
  List<int> days, {
  required bool isOffset,
  required double w,
  required double h,
  required List<int> savedDays,
  required Function(int) onDayTap,
}) {
  double offsetX = isOffset ? (w / 2) + 1 : 0;
  double offsetY = -h * 0.22;

  return Transform.translate(
    offset: Offset(offsetX, offsetY),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: days.map((day) {
        if (day == -1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1),
            child: HoneycombWidget(
              dayText: "",
              bgColor: const Color(0xffFFFDF0),
              width: w,
              height: h,
              hasAlert: true,
            ),
          );
        }

        bool isSaved = savedDays.contains(day);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 1),
          child: HoneycombWidget(
            dayText: day.toString(),
            bgColor:
                isSaved ? const Color(0xffFFAA2C) : const Color(0xffF5EEDB),
            textColor: isSaved ? Colors.white : Colors.grey[600]!,
            width: w,
            height: h,
            onTap: () => onDayTap(day),
          ),
        );
      }).toList(),
    ),
  );
}

// --- LEGEND ITEM GENERATOR ---
Widget buildLegendItem(Color color, String text) {
  return Row(
    children: [
      CustomPaint(
        size: const Size(16, 18),
        painter: HexagonPainter(color: color),
      ),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
