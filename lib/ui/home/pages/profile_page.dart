import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/home/pages/home_page.dart';
import 'package:flutter_nabee/ui/home/pages/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/pages/edit_profile_page.dart';// Import diaktifkan
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Index aktif dikunci ke posisi 2 (Profile) saat halaman ini dibuka
  int selectedIndex = 2; 

  @override
  Widget build(BuildContext context) {
    // Mengambil data ukuran layar perangkat agar lebih responsive
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      // BAGIAN UTAMA: Navigasi Aktif ke HomePage dan HoneyJarPage
      bottomNavigationBar: Container(
        height: 75,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE28A24),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 1. PINDAH KE HOME (Index 0)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: _navItem("assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),

            // 2. PINDAH KE HONEY JAR (Index 1)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HoneyJarPage()),
                );
              },
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar", selectedIndex == 1),
            ),

            // 3. STAY DI PROFILE (Index 2)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                // Tetap di halaman ini
              },
              child: _navItem("assets/icons/nav/profile.svg", "Profile", selectedIndex == 2),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            // Honeycomb Background
            Positioned(
              top: -10,
              right: -10,
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  "assets/images/sarang_lebah_atas.png",
                  width: screenWidth * 0.3,
                ),
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // FOTO PROFILE
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECC488),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE28A24),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Salmaa",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "idn2026@gmail.com",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  // Button Edit Profile
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE28A24),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfilePage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // CHARACTER LEVEL TITLE
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Character Level",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // CHARACTER CARD
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4C8),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE28A24)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFC8F26D),
                            border: Border.all(
                              color: const Color(0xFF66C13D),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset("assets/images/ulet_happy.png"),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Caterpillar",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4E1F0F),
                                ),
                              ),

                              const SizedBox(height: 14),

                              Row(
                                children: [
                                  // LEVEL 1
                                  ClipPath(
                                    clipper: _HexagonClipper(),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      color: const Color(0xFF5DBA43),
                                      child: const Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Progress Bar
                                  Expanded(
                                    child: Container(
                                      height: 12,
                                      color: const Color(0xFFE5C56F),
                                    ),
                                  ),

                                  // LEVEL 2
                                  ClipPath(
                                    clipper: _HexagonClipper(),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      color: const Color(0xFFE4BE2D),
                                      child: const Center(
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "account settings",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _settingTile("Setting"),

                  const SizedBox(height: 10),

                  _settingTile("Notifications"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _settingTile(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F1DF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF4E1F0F)),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Color(0xFF4E1F0F)),
        ],
      ),
    );
  }

  Widget _navItem(String icon, String label, bool active) {
    final Color itemColor = active ? Colors.white : const Color(0xFF5C3818);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: itemColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    return Path()
      ..moveTo(w * 0.25, 0)
      ..lineTo(w * 0.75, 0)
      ..lineTo(w, h * 0.5)
      ..lineTo(w * 0.75, h)
      ..lineTo(w * 0.25, h)
      ..lineTo(0, h * 0.5)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}