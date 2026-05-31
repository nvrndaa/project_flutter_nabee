import 'dart:async';
import 'package:flutter/material.dart';
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
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const onboarding_page1(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E4),
      body: Center(
        child: Image.asset(
          'assets/images/logo_nabee.png',
          width: 220,
        ),
      ),
    );
  }
}