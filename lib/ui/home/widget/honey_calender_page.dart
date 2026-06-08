import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneyCalendarPage extends StatefulWidget {
  final dynamic jar;

  const HoneyCalendarPage({super.key, required this.jar});

  @override
  State<HoneyCalendarPage> createState() => _HoneyCalendarPageState();
}

class _HoneyCalendarPageState extends State<HoneyCalendarPage> {
  // Simulasi data tersimpan
  final List<int> savedDays = [1, 2, 3, 5, 6, 8, 9, 10, 11, 12, 14, 15, 16, 17];

  void showHoneySavingDialog(int day) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return HoneySavingDialog(
          day: day,
          onSave: (amount) {
            debugPrint("Menyimpan madu untuk hari ke-$day sebesar Rp. $amount");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Ambil nama toples secara dinamis dari parameter, berikan fallback jika null
    final String jarName =
        widget.jar != null ? widget.jar.name : "New year bali trip";

    // Kalkulasi ukuran dinamis untuk hexagon sarang lebah berdasarkan lebar layar
    double hexWidth = screenWidth * 0.105;
    if (hexWidth > 42) hexWidth = 42;
    double hexHeight = hexWidth * 1.15;

    // Kompensasi tinggi vertikal negatif untuk efek merapat/overlap sarang lebah
    double honeyGridOverlapCompensation = hexHeight * 0.22;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. DEKORASI SARANG LEBAH BACKGROUND (Mentok Ujung Atas Layar)
          Positioned(
            top: 0, 
            right: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/sarang_lebah_atas.png",
                width: 150,
              ),
            ),
          ),

          // 2. KONTEN UTAMA HALAMAN
          SafeArea(
            child: Column(
              children: [
                // --- CUSTOM APP BAR ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xff5C3818)),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        jarName,
                        style: const TextStyle(
                          color: Color(0xff5C3818),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                // ISI KONTEN DI DALAM SCROLLVIEW
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        // SECTION TOPLES & PROGRES
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: 220,
                                child: Image.asset(
                                  "assets/images/empty_jar.png",
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 220,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFF7E9),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: AppColors.orange,
                                          width: 3,
                                        ),
                                      ),
                                      child: const Center(
                                          child: Icon(Icons.layers_outlined,
                                              size: 50, color: AppColors.orange)),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 45), 
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
                                    Row(
                                      children: List.generate(
                                          15,
                                          (index) => Expanded(
                                                child: Container(
                                                    height: 2,
                                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                                    color: AppColors.orange),
                                              )),
                                    ),
                                    const SizedBox(height: 6),
                                    const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Rp. 2,250,000",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff5C3818),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // SECTION DUE DATE & MONEY LEFT
                        Row(
                          children: [
                            Expanded(
                              child: buildInfoCard(
                                iconPath: "assets/icons/target_salved.svg",
                                fallbackIcon: Icons.track_changes_rounded,
                                title: "Due date",
                                value: "1 Dec, 2026",
                                valueColor: const Color(0xff5C3818),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: buildInfoCard(
                                iconPath: "assets/icons/coin.svg",
                                fallbackIcon: Icons.monetization_on_rounded,
                                title: "Money left",
                                value: "-2,750,000",
                                valueColor: AppColors.orange,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // SECTION KALENDER SARANG LEBAH
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFDF0),
                            borderRadius: BorderRadius.circular(24),
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
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.chevron_left, color: Colors.grey[600], size: 22),
                                      const SizedBox(width: 15),
                                      Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Grid Angka Kalender Honeycomb
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      buildHoneycombRow([1, 2, 3, 4, 5, 6], isOffset: false, w: hexWidth, h: hexHeight),
                                      buildHoneycombRow([7, 8, 9, 10, 11, 12], isOffset: true, w: hexWidth, h: hexHeight),
                                      buildHoneycombRow([13, 14, 15, 16, 17, -1], isOffset: false, w: hexWidth, h: hexHeight), 
                                      buildHoneycombRow([18, 19, 20, 21, 22, 23, 24], isOffset: true, w: hexWidth, h: hexHeight),
                                      buildHoneycombRow([25, 26, 27, 28, 29, 30], isOffset: false, w: hexWidth, h: hexHeight),
                                      buildHoneycombRow([31], isOffset: true, w: hexWidth, h: hexHeight),

                                      SizedBox(height: honeyGridOverlapCompensation),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Keterangan Warna (Legend)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildLegendItem(const Color(0xffF5EEDB), "= Empty"),
                                  const SizedBox(width: 30),
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
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orange.withOpacity(0.6), width: 1.5),
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
              width: 22,
              height: 22,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(fallbackIcon, color: const Color(0xffE8A44C), size: 22),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHoneycombRow(List<int> days,
      {required bool isOffset, required double w, required double h}) {
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
              bgColor: isSaved ? const Color(0xffFFAA2C) : const Color(0xffF5EEDB),
              textColor: isSaved ? Colors.white : Colors.grey[600]!,
              width: w,
              height: h,
              onTap: () {
                showHoneySavingDialog(day);
              },
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
}

// =================================================================
// WIDGET-WIDGET PEMBANTU (DI TARUH DI BAWAH LUAR CLASS UTAMA)
// =================================================================

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

class HoneySavingDialog extends StatefulWidget {
  final int day;
  final Function(String) onSave;

  const HoneySavingDialog({super.key, required this.day, required this.onSave});

  @override
  State<HoneySavingDialog> createState() => _HoneySavingDialogState();
}

class _HoneySavingDialogState extends State<HoneySavingDialog> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Honey Saving",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brownText,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "How much honey do you want\nto save on day ${widget.day}?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.brownText, height: 1.4),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Rp.",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(color: AppColors.orange, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(color: AppColors.orange, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    widget.onSave(_amountController.text);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}