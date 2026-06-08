import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/widget/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/widget/notification_page.dart';
import 'package:flutter_nabee/ui/home/widget/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String petName = "Salma";

  // 1. Ubah menjadi variabel biasa (bukan final) agar nilainya bisa diperbarui
  int selectedIndex = 0;

  void _showEditNameDialog() {
  final TextEditingController nameController =
      TextEditingController(text: petName);

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Latar belakang default dibuat transparan
        insetPadding: const EdgeInsets.symmetric(horizontal: 40), // Jarak aman ke tepi layar
        child: SizedBox(
          width: 260, // Lebar kotak dikunci agar proporsional mirip kapsul di gambar
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35), // Sudut sangat bulat membentuk kapsul
              border: Border.all(
                color: const Color(0xFFF1B71C), // Warna border kuning/oranye keemasan sesuai gambar
                width: 3,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Tinggi pas mengikuti isi
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  textAlign: TextAlign.center, // Teks otomatis di tengah
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E1F0F), // Warna cokelat gelap teks
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Menghilangkan garis bawah bawaan TextField
                    hintText: "Nama",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                    // Menyimpan otomatis ketika user menekan 'Enter' atau 'Done' di keyboard
                    if (value.trim().isNotEmpty) {
                      setState(() {
                        petName = value.trim();
                      });
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 75,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // HOME (Index 0)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                // Karena ini sudah di HomePage, tidak perlu pushReplacement ke diri sendiri
              },
              // 2. Cek apakah selectedIndex == 0 untuk menentukan status aktif
              child: _navItem(
                  "assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),

            // HONEY JAR (Index 1)
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
              // 2. Cek apakah selectedIndex == 1
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar",
                  selectedIndex == 1),
            ),

            // PROFILE (Index 2)
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                ).then((_) {
                  // Ketika kembali dari ProfilePage, kembalikan posisi aktif ke Home
                  setState(() {
                    selectedIndex = 0;
                  });
                });
              },
              // 2. Cek apakah selectedIndex == 2
              child: _navItem("assets/icons/nav/profile.svg", "Profile",
                  selectedIndex == 2),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hi, $petName!",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brownText),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotificationPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: AppColors.orange, shape: BoxShape.circle),
                          child: SvgPicture.asset("assets/icons/notif.svg",
                              color: Colors.white, width: 20, height: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: _statCard(
                        icon: "assets/icons/target_salved.svg",
                        title: "Target solved",
                        value: "0 Jars",
                      )),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _statCard(
                              icon: "assets/icons/coin.svg",
                              title: "Money saved",
                              value: "0 Rupiah")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                        Image.asset("assets/images/ulet_happy.png",
                            height: 220),
                        const SizedBox(height: 10),

                        // --- TOMBOL NAMA KAPSUL + LOGO PENSIL MELAYANG ---
                        GestureDetector(
                          onTap: _showEditNameDialog,
                          child: SizedBox(
                            width:
                                150, // Atur lebar total kapsul sesuai kebutuhan layoutmu
                            height:
                                65, // Atur tinggi total agar memberi ruang untuk lingkaran pensil di atas
                            child: Stack(
                              clipBehavior: Clip
                                  .none, // Penting agar lingkaran pensil tidak terpotong saat melayang keluar
                              children: [
                                // 1. Kapsul Nama Utama (Paling Belakang)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top:
                                      10, // Memberi sedikit ruang di atas agar pensil bisa melayang melewati border
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors
                                          .softYellow, // Latar belakang putih/abu sangat muda sesuai gambar
                                      borderRadius: BorderRadius.circular(
                                          30), // Membuat bentuk lonjong/kapsul sempurna
                                      border: Border.all(
                                        color: const Color(
                                            0xffEBB700), // Warna border kuning pekat sesuai image_ce160c.png
                                        width: 4, // Border dibuat tebal
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        petName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors
                                              .brownText, // Warna teks cokelat tua
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 2. Tombol Bulat Pensil (Melayang di Pojok Kanan Atas)
                                Positioned(
                                  top: 0,
                                  right:
                                      10, // Geser posisi horizontal lingkaran pensilnya di sini
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(
                                            0xffEBB700), // Border kuning tebal yang sama
                                        width: 3.5,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons
                                            .edit, // Gunakan Icons.edit bawaan, atau ganti ke Icon khusus gambar pensilmu
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
                        // -------------------------------------------------
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Honey tips",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E1F0F)),
                  ),
                  const SizedBox(height: 12),
                  _tipsCard(
                    image: "assets/images/bee.png",
                    tag: "Economic Growth",
                    title: "Money matters: Your guide to financial literacy",
                    source: "World Economic Forum",
                    date: "May 3, 2024",
                  ),
                  const SizedBox(height: 12),
                  _tipsCard(
                    image: "assets/images/bee.png",
                    tag: "Saving",
                    title:
                        "Smart Finance Management Tips to Avoid Wasteful Spending",
                    source: "PT Bank Tabungan Negara",
                    date: "Dec 23, 2024",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
      {required String icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.orange),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 22, height: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 10)),
                Text(value,
                    style: const TextStyle(
                        color: AppColors.orange, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipsCard(
      {required String image,
      required String tag,
      required String title,
      required String source,
      required String date}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.softYellow, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(image, width: 95, height: 95, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(tag, style: const TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(height: 5),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(source, style: const TextStyle(fontSize: 11)),
                  Text(date, style: const TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Modifikasi fungsi _navItem untuk merespons perubahan warna secara penuh
  Widget _navItem(String icon, String label, bool active) {
    // Tentukan warna berdasarkan status halaman aktif atau tidak
    final Color itemColor = active ? Colors.white : AppColors.brownText;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          // Menggunakan colorFilter agar warna ikon SVG berubah menjadi putih/cokelat
          colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: itemColor, // Mengikuti warna status aktif
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
