import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';


class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Sarang lebah atas kiri
          Positioned(
            top: 0,
            left: -10,
            child: Image.asset(
              'assets/images/sarang_lebah_atas.png',
              width: 180,
              cacheWidth: 250,
            ),
          ),

          // Sarang lebah bawah kanan
          Positioned(
            bottom: -5,
            right: -20,
            child: Image.asset(
              'assets/images/sarang_lebah_bawah.png',
              width: 180,
              cacheWidth: 250,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 120),

                  // Gambar lebah
                  Center(
                    child: Image.asset(
                      'assets/images/bee.png',
                      width: 240,
                      cacheWidth: 350,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Level Up!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Develop your character and \nunlock new costume for every \ntarget you achieve.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.brownText),
                  ),

                  const SizedBox(height: 38),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
