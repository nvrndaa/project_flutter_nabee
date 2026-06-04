import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneyCalendarPage extends StatefulWidget {
  const HoneyCalendarPage({super.key});

  @override
  State<HoneyCalendarPage> createState() => _HoneyCalendarPageState();
}

class _HoneyCalendarPageState extends State<HoneyCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff5C3818)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "New year bali trip",
          style: TextStyle(
            color: Color(0xff5C3818),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // 1. SECTION TOPLES & PROGRES
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 240,
                      child: Image.asset(
                        "assets/images/empty_jar.png", 
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCECD2),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: const Color(0xffE38D1A), width: 3),
                            ),
                            child: const Center(child: Text("Toples Madu")),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "45%",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff5C3818),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(height: 2, color: const Color(0xffF2A900)),
                          const SizedBox(height: 4),
                          const Text(
                            "Rp. 2,250,000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff8A5426),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 2. SECTION DUE DATE & MONEY LEFT
              Row(
                children: [
                  Expanded(
                    child: buildInfoCard(
                      iconPath: "assets/icons/target_salved.svg",
                      fallbackIcon: Icons.track_changes_rounded,
                      title: "Due date",
                      value: "1 Dec, 2026",
                      valueColor: const Color(0xff8A5426),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: buildInfoCard(
                      iconPath: "assets/icons/coin.svg",
                      fallbackIcon: Icons.monetization_on_rounded,
                      title: "Money left",
                      value: "-2,750,000",
                      valueColor: const Color(0xffF2A900),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 3. SECTION KALENDER SARANG LEBAH
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFDF0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Saving calendar",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5C3818),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "May, 2026",
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.chevron_left, color: Colors.grey[600], size: 20),
                            const SizedBox(width: 10),
                            Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Grid Angka Kalender
                    Center(
                      child: Column(
                        children: [
                          buildHoneycombRow([1, 2, 3, 4, 5, 6], isOffset: false),
                          buildHoneycombRow([7, 8, 9, 10, 11, 12], isOffset: true),
                          buildHoneycombRow([13, 14, 15, 16, 17, -1], isOffset: false), // -1 untuk tanda seru (!)
                          buildHoneycombRow([18, 19, 20, 21, 22, 23, 24], isOffset: true),
                          buildHoneycombRow([25, 26, 27, 28, 29, 30], isOffset: false),
                          buildHoneycombRow([31], isOffset: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    
                    // Keterangan Warna (Legend)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildLegendItem(const Color(0xffF5EEDB), "= Empty"),
                        const SizedBox(width: 20),
                        buildLegendItem(const Color(0xffFFAA2C), "= Saved"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required String iconPath,
    required IconData fallbackIcon,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE8A44C), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xffFEF5E7),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) => Icon(fallbackIcon, color: const Color(0xffE8A44C)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: valueColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHoneycombRow(List<int> days, {required bool isOffset}) {
    final List<int> savedDays = [1, 2, 3, 5, 6, 8, 9, 10, 11, 12, 14, 15, 16, 17];

    return Transform.translate(
      offset: Offset(isOffset ? 21 : 0, -8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: days.map((day) {
          if (day == -1) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: HoneycombWidget(
                dayText: "",
                bgColor: Color(0xffFFFDF0),
                borderColor: Color(0xffFFAA2C),
                hasAlert: true,
              ),
            );
          }

          bool isSaved = savedDays.contains(day);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: HoneycombWidget(
              dayText: day.toString(),
              bgColor: isSaved ? const Color(0xffFFAA2C) : const Color(0xffF5EEDB),
              textColor: isSaved ? Colors.white : Colors.grey[600]!,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildLegendItem(Color color, String text) {
    return Row(
      children: [
        CustomPaint(
          size: const Size(16, 18),
          painter: HexagonPainter(color: color),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class HoneycombWidget extends StatelessWidget {
  final String dayText;
  final Color bgColor;
  final Color? textColor;
  final Color? borderColor;
  final bool hasAlert;

  const HoneycombWidget({
    super.key,
    required this.dayText,
    required this.bgColor,
    this.textColor,
    this.borderColor,
    this.hasAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(38, 42),
          painter: HexagonPainter(
            color: bgColor,
            borderColor: borderColor,
          ),
        ),
        if (!hasAlert)
          Text(
            dayText,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        if (hasAlert)
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                "!",
                style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
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
        ..strokeWidth = 1.5;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}