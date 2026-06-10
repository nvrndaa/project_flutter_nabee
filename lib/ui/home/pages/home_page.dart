import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/pages/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/pages/notification_page.dart';
import 'package:flutter_nabee/ui/home/pages/profile_page.dart';
import 'package:flutter_nabee/ui/home/widget/stat_card.dart';
import 'package:flutter_nabee/ui/home/dialog/edit_name_dialog.dart'; // Jalur import dialog barumu!
import 'package:flutter_nabee/ui/home/widget/honey_tips_section.dart'; // Widget list artikel API Laravel
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String petName = "Salma";
  int selectedIndex = 0;

  // Fungsi buat manggil popup dialog ganti nama
  void _showEditNameDialog() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => EditNameDialog(currentName: petName),
    );

    if (newName != null && mounted) {
      setState(() {
        petName = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavbar(),
      body: SafeArea(
        child: Stack(
          children: [
            // Background sarang lebah atas kanan
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset("assets/images/sarang_lebah_atas.png",
                    width: 140),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildStatCards(),
                  const SizedBox(height: 20),
                  _buildPetSection(),
                  const SizedBox(height: 25),

                  // Bagian Honey Tips yang ambil data real-time dari API Laravel
                  const HoneyTipsSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SUB-WIDGET BUILDER =================

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hi, $petName!",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.brownText,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.orange, shape: BoxShape.circle),
            child: SvgPicture.asset(
              "assets/icons/notif.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 16,
              height: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        const Expanded(
          child: StatCard(
            icon: "assets/icons/target_salved.svg",
            title: "Target solved",
            value: "0 Jars",
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: StatCard(
            icon: "assets/icons/coin.svg",
            title: "Money saved",
            value: "0 Rupiah",
          ),
        ),
      ],
    );
  }

  Widget _buildPetSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage("assets/images/background_ulet.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Image.asset("assets/images/ulet_happy.png", height: 220),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showEditNameDialog,
            child: SizedBox(
              width: 150,
              height: 65,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.softYellow,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xffEBB700),
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          petName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brownText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffEBB700),
                          width: 3.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Color(0xffEBB700),
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

  Widget _buildBottomNavbar() {
    return Container(
      height: 75,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => setState(() => selectedIndex = 0),
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
            onTap: () {
              setState(() => selectedIndex = 2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              ).then((_) {
                setState(() => selectedIndex = 0);
              });
            },
            child: _navItem(
                "assets/icons/nav/profile.svg", "Profile", selectedIndex == 2),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String icon, String label, bool active) {
    final Color itemColor = active ? Colors.white : AppColors.brownText;
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
