import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';

class CaterpillarPopupPage extends StatelessWidget {
  const CaterpillarPopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC5B58D),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 70),

              // ===== GANTI DENGAN ASSET GAMBAR KAMU =====
              Image.asset(
                'assets/images/popupbaby.png',
                width: 280,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Finish your every daily task to keep\n'
                  'your friend happy! watch them grow\n'
                  'every time you finish enough task.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.softYellow,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE58D1E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Lets go!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}