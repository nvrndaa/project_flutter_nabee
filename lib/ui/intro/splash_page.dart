import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page1.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3), // 3 detik aja biar ga kelamaan nunggu
      () {
        // 💡 DI SINI KUNCI PERUBAHANNYA:
        // Kita arahkan ke LoginPage() milik temenmu, bukan ke onboarding langsung!
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingPage1(), 
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softYellow,
      body: Center(
        child: Image.asset(
          'assets/images/logo_nabee.png',
          width: 200,
          errorBuilder: (context, error, stackTrace) {
            // Biar gak crash kalau gambarnya sempat hilang/salah jalur asset
            return const Icon(Icons.flutter_dash, size: 100, color: Colors.orange);
          },
        ),
      ),
    );
  }
}