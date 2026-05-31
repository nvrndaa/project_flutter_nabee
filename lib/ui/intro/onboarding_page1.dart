import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page2.dart';

class onboarding_page1 extends StatelessWidget {
  const onboarding_page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          // Sarang lebah atas kiri
          Positioned(
            top: -10,
            left: -10,
            child: Image.asset(
              'assets/images/sarang_lebah_atas.png',
              width: 180,
            ),
          ),

          // Sarang lebah bawah kanan
          Positioned(
            bottom: -20,
            right: -20,
            child: Image.asset(
              'assets/images/sarang_lebah_bawah.png',
              width: 170,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 130),

                  // Gambar lebah
                  Center(
                    child: Image.asset(
                      'assets/images/bee_coin.png',
                      width: 200,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Start your saving journey here\nwith your bee companion.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF4E1F0F)),
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
                            builder: (_) => const onboarding_page2(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE28A24),
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
