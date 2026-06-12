import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/home/pages/home_page.dart';
import 'package:flutter_nabee/ui/home/pages/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/pages/edit_profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: _navItem(
                  "assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HoneyJarPage()),
                );
              },
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar",
                  selectedIndex == 1),
            ),
            GestureDetector(
              onTap: () {},
              child: _navItem("assets/icons/nav/profile.svg", "Profile",
                  selectedIndex == 2),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Sarang Lebah di Kanan Atas
            Positioned(
              top: -10,
              right: -10,
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  "assets/images/sarang_lebah_atas.png",
                  width: screenWidth * 0.35,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // ================= SEKSI UTAMA PROFIL ATAS =================
                  // Avatar Kamera
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF0A243).withOpacity(0.4),
                      border: Border.all(
                        color: const Color(0xFFE28A24),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/camera.svg",
                        width: 45,
                        height: 45,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Nama User
                  const Text(
                    "Salmaa",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email User
                  const Text(
                    "idn2026@gmail.com",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Edit Profile Orange
                  SizedBox(
                    width: 160,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE28A24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // =========================================================

                  const SizedBox(height: 28),

                  // TITLE: Character Level
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Character Level",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // CARD KUNING: Character Level
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1C2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Avatar Ulat Hijau Bulat
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF5CD143),
                              width: 2.5,
                            ),
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                "assets/images/ulet_happy.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Nama Karakter & Progress Level Bar
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Caterpillar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4E1F0F),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // AREA PROGRESS BAR (Sudah Nempel Sempurna ke Icon 1)
                              // AREA PROGRESS BAR (Menggunakan Transform untuk Menghilangkan Celah Bawaan SVG)
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Icon Level 1 Lengkap (dari Asset)
                                  SvgPicture.asset(
                                    "assets/icons/satu.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  // Bar Cokelat Sengon (Digeser ke kiri secara paksa agar menempel)
                                  Expanded(
                                    child: Transform.translate(
                                      offset: const Offset(-3,
                                          0), // <--- Menggeser bar 3 piksel ke kiri menembus whitespace SVG
                                      child: Container(
                                        height: 14,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFD3A273),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Icon Level 2 Lengkap (dari Asset)
                                  SvgPicture.asset(
                                    "assets/icons/dua.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
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

                  // SEKSI ACCOUNT SETTINGS
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "account settings",
                      style: TextStyle(
                        color: Color(0xFF4E1F0F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF4E1F0F),
              fontSize: 15,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Color(0xFF4E1F0F), size: 20),
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
