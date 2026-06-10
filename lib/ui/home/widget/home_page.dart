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

  int selectedIndex = 0;

  void _showEditNameDialog() {
  final TextEditingController nameController =
      TextEditingController(text: petName);

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, 
        insetPadding: const EdgeInsets.symmetric(horizontal: 40), 
        child: SizedBox(
          width: 260, // Lebar kotak dikunci agar proporsional mirip kapsul di gambar
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35), 
              border: Border.all(
                color: const Color(0xFFF1B71C), 
                width: 3,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  textAlign: TextAlign.center, 
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brownText, 
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none, 
                    hintText: "Nama",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
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
              },
              child: _navItem(
                  "assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),

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
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar",
                  selectedIndex == 1),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                ).then((_) {
                  setState(() {
                    selectedIndex = 0;
                  });
                });
              },
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

                        GestureDetector(
                          onTap: _showEditNameDialog,
                          child: SizedBox(
                            width:
                                150, 
                            height:
                                65, 
                            child: Stack(
                              clipBehavior: Clip
                                  .none, 
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top:
                                      10, 
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors
                                          .softYellow, 
                                      borderRadius: BorderRadius.circular(
                                          30), 
                                      border: Border.all(
                                        color: const Color(
                                            0xffEBB700), 
                                        width: 4,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        petName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors
                                              .brownText, 
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 0,
                                  right:
                                      10, 
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(
                                            0xffEBB700), 
                                        width: 3.5,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons
                                            .edit, 
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
