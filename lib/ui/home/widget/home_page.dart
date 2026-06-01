import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

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
            _navItem(
              "assets/icons/nav/logout.svg",
              "Home",
              true,
            ),
            _navItem(
              "assets/icons/nav/camera.svg",
              "Honey jar",
              false,
            ),
            _navItem(
              "assets/icons/nav/profile.svg",
              "Profile",
              false,
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Header
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hi, Salmaa!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE28A24),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/timer.svg",
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Statistik
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: "assets/icons/plus.svg",
                      title: "Target solved",
                      value: "0 Jars",
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _statCard(
                      icon: "assets/icons/coin.svg",
                      title: "Money saved",
                      value: "0 Rupiah",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Kartu Hewan
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4E4B8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/ulet_happy.png",
                      height: 220,
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD34F),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E1F0F),
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
                  color: Color(0xFF4E1F0F),
                ),
              ),

              const SizedBox(height: 12),

              _tipsCard(
                image: "assets/images/bee.png",
                tag: "Economic Growth",
                title:
                    "Money matters: Your guide to financial literacy",
                source: "World Economic Forum",
                date: "May 3, 2024",
              ),

              const SizedBox(height: 12),

              _tipsCard(
                image: "assets/images/bee.png",
                tag: "Saving",
                title:
                    "Smart Finance Management Tips to Avoid Wasteful Spending",
                source:
                    "PT Bank Tabungan Negara",
                date: "Dec 23, 2024",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard({
    required String icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE28A24),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFFE28A24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tipsCard({
    required String image,
    required String tag,
    required String title,
    required String source,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3EEDB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              image,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    title,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    source,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),

                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 11,
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

  Widget _navItem(
    String icon,
    String label,
    bool active,
  ) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}