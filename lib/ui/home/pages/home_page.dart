import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/pages/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/pages/notification_page.dart';
import 'package:flutter_nabee/ui/home/pages/profile_page.dart';
import 'package:flutter_nabee/ui/home/widget/stat_card.dart';
import 'package:flutter_nabee/ui/home/dialog/edit_name_dialog.dart';
import 'package:flutter_nabee/ui/home/widget/honey_tips_section.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
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

                  // Bagian Nearest Target (toples tabungan user)
                  if (JarModel.jars.isNotEmpty) ...[
                    _buildNearestTargetSection(),
                    const SizedBox(height: 25),
                  ],

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
          Image.asset("assets/images/ulet_happy.png", height: 180),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showEditNameDialog,
            child: SizedBox(
              width: 140, // Disesuaikan sedikit lebarnya agar pas
              height: 40, // Tinggi kontainer nama dibuat lebih ideal
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. KOTAK UTAMA UNTUK NAMA (Warna putih dengan border kuning tebal)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors
                            .white, // Latar belakang putih bersih sesuai gambar
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(
                              0xffEBB700), // Garis tepi kuning pekat di luar
                          width: 3.0, // Ketebalan border luar
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right:
                                  12), // Memberi space agar teks tidak tertutup tombol pensil
                          child: Text(
                            petName, // Menampilkan "Salma"
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color:
                                  Color(0xFF4E1F0F), // Warna teks cokelat tua
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 2. TOMBOL EDIT PENSIL (Menempel pas di sudut kanan)
                  // ================= SEBELUMNYA (_buildPetSection) =================
                  Positioned(
                    top: -6,
                    right: 10,
                    child: Container(
                      width: 26, // Diperkecil dari 38 -> 26
                      height: 26, // Diperkecil dari 38 -> 26
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffEBB700),
                          width:
                              2.0, // Ditipiskan dari 3.5 -> 2.0 agar lebih clean
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          size:
                              12, // Diperkecil dari 16 -> 12 agar muat sempurna
                          color: Color(0xffEBB700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNearestTargetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nearest Target",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brownText,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        ...JarModel.jars.map(_buildJarCard),
      ],
    );
  }

  Widget _buildJarCard(JarModel jar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        // Menambahkan clipBehavior agar kemiringan konten di dalam pas dengan lekukan kartu
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: const Color(0xFFFDE674), 
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          height: 105, // Mengunci tinggi total kartu agar konsisten
          child: Stack(
            children: [
              // 1. Gambar Toples (Nempel dasar bawah kartu)
              Positioned(
                left: 16,
                bottom: -22, 
                child: Image.asset(
                  "assets/images/empty_jar.png",
                  width: 75,
                  height: 110, 
                  fit: BoxFit.contain, 
                ),
              ),
              
              // 2. Area Teks Informasi (Diatur mepet ke kanan bawah kartu)
              Positioned(
                left: 107, 
                right: 16,
                top: 14,
                bottom: 6, // Diperkecil dari 12 ke 6 agar teks "45% saved" mepet ke bawah mengikuti lengkungan
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    // Judul & Panah
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            jar.name, 
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A2000),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF4A2000),
                          size: 24,
                        ),
                      ],
                    ),
                    
                    // Tanggal Target
                    const Text(
                      "1 Dec, 2026", 
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6D5333),
                      ),
                    ),
                    
                    // Progress Bar & Teks Persentase (Bagian yang kamu maksud)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kapsul Progress Bar Putih
                        Container(
                          height: 16, // Sedikit ditinggikan agar bar terasa tebal padat
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white, // Putih solid sesuai gambar zoom-in kamu
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2), // Efek border track padding internal
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 0.45, 
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC00), 
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2), // Jarak tipis antara bar dengan teks di bawahnya
                        
                        // Teks Persentase Mepet Bawah
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "45% saved",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4A2000),
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
