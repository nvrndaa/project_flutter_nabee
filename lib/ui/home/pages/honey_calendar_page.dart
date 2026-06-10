import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/widget/honeycomb_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

// --- IMPORT FILE PECAHAN BARU ---
import 'package:flutter_nabee/ui/home/dialog/honey_saving_dialog.dart';


class HoneyCalendarPage extends StatefulWidget {
  final dynamic jar;

  const HoneyCalendarPage({super.key, required this.jar});

  @override
  State<HoneyCalendarPage> createState() => _HoneyCalendarPageState();
}

class _HoneyCalendarPageState extends State<HoneyCalendarPage> {
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
    final String jarName =
        widget.jar != null ? widget.jar.name : "New year bali trip";

    double hexWidth = screenWidth * 0.105;
    if (hexWidth > 42) hexWidth = 42;
    double hexHeight = hexWidth * 1.15;
    double honeyGridOverlapCompensation = hexHeight * 0.22;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          SafeArea(
            child: Column(
              children: [
                // CUSTOM APP BAR
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xff5C3818)),
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // TOPLES PROFILE ROW
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
                                            color: AppColors.orange, width: 3),
                                      ),
                                      child: const Center(
                                          child: Icon(Icons.layers_outlined,
                                              size: 50,
                                              color: AppColors.orange)),
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
                                            height: 22,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            color: AppColors.orange,
                                          ),
                                        ),
                                      ),
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
                        // INFO CARDS TARGET & SISA COIN
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
                        // CONTAINER GRID UTAMA
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Icon(Icons.chevron_left,
                                          color: Colors.grey[600], size: 22),
                                      const SizedBox(width: 15),
                                      Icon(Icons.chevron_right,
                                          color: Colors.grey[600], size: 22),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Grid Pemanggilan Hasil Ekstraksi
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      buildHoneycombRow([1, 2, 3, 4, 5, 6],
                                          isOffset: false,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      buildHoneycombRow([7, 8, 9, 10, 11, 12],
                                          isOffset: true,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      buildHoneycombRow(
                                          [13, 14, 15, 16, 17, -1],
                                          isOffset: false,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      buildHoneycombRow(
                                          [18, 19, 20, 21, 22, 23, 24],
                                          isOffset: true,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      buildHoneycombRow(
                                          [25, 26, 27, 28, 29, 30],
                                          isOffset: false,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      buildHoneycombRow([31],
                                          isOffset: true,
                                          w: hexWidth,
                                          h: hexHeight,
                                          savedDays: savedDays,
                                          onDayTap: showHoneySavingDialog),
                                      SizedBox(
                                          height: honeyGridOverlapCompensation),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildLegendItem(
                                      const Color(0xffF5EEDB), "= Empty"),
                                  const SizedBox(width: 30),
                                  buildLegendItem(
                                      const Color(0xffFFAA2C), "= Saved"),
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
        border:
            Border.all(color: AppColors.orange.withOpacity(0.6), width: 1.5),
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
}
