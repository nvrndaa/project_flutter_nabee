import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/pages/honey_calendar_page.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

// --- WIDGET RAK KAYU ---
Widget buildShelf() {
  return Stack(
    children: [
      Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.rakSatu,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.rakDua,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    ],
  );
}

// --- WIDGET TOPLES ---
Widget buildJarWidget(
    BuildContext context, JarModel jar, double availableWidth) {
  double jarWidth = (availableWidth - 80) / 3;
  if (jarWidth > 90) jarWidth = 90;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HoneyCalendarPage(jar: jar)),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: jarWidth * 1.15,
          width: jarWidth,
          child: Image.asset(
            "assets/images/empty_jar.png",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.liquor, size: 50, color: AppColors.orange),
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: jarWidth + 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.softYellow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            jar.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// --- WIDGET BUTTON PLUS ---
Widget buildAddButton(double availableWidth, VoidCallback onTap) {
  double btnSize = (availableWidth - 80) / 3;
  if (btnSize > 80) btnSize = 80;

  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: btnSize,
          height: btnSize,
          margin: const EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: AppColors.buttonPlus,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/plus.svg",
              width: btnSize * 0.6,
              height: btnSize * 0.6,
              colorFilter:
                  const ColorFilter.mode(AppColors.rakDua, BlendMode.srcIn),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.add, color: AppColors.rakSatu),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
