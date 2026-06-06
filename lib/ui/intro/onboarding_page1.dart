import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page2.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -10,
            child: Image.asset(
              'assets/images/sarang_lebah_atas.png',
              width: 180,
              cacheWidth: 250,
            ),
          ),

          Positioned(
            bottom: -5,
            right: -20,
            child: Image.asset(
              'assets/images/sarang_lebah_bawah.png',
              width: 200,
              cacheWidth: 250,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 150),

                  Center(
                    child: Image.asset(
                      'assets/images/bee_coin.png',
                      width: 220,
                      cacheWidth: 350,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Start your saving journey here\nwith your bee companion.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.brownText),
                  ),

                  const SizedBox(height: 45),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnboardingPage2(),
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
