import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/home/pages/home_page.dart';
import 'package:flutter_nabee/ui/home/widget/honey_shelf_widget.dart';
import 'package:flutter_nabee/ui/home/pages/profile_page.dart';

// --- HUBUNGKAN KE FOLDER DIALOG DAN WIDGET ---
import 'package:flutter_nabee/ui/home/dialog/add_jar_dialog.dart';

// --- IMPORT MODEL ---
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneyJarPage extends StatefulWidget {
  const HoneyJarPage({super.key});

  @override
  State<HoneyJarPage> createState() => _HoneyJarPageState();
}

class _HoneyJarPageState extends State<HoneyJarPage> {
  final List<JarModel> jars = [];
  int selectedIndex = 1;

  void showAddJarDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AddJarDialog(
        onSave: (newJar) {
          setState(() {
            jars.add(newJar);
          });
        },
      ),
    );
  }

  Widget _navItem(String icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 22,
          height: 22,
          colorFilter: ColorFilter.mode(
              isActive ? Colors.white : const Color(0xff5C3818),
              BlendMode.srcIn),
          errorBuilder: (context, error, stackTrace) => Icon(
            isActive ? Icons.circle : Icons.circle_outlined,
            color: isActive ? Colors.white : const Color(0xff5C3818),
            size: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xff5C3818),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xffE38D1A),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));
              },
              child: _navItem(
                  "assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 1);
              },
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar",
                  selectedIndex == 1),
            ),
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()));
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
                opacity: .15,
                child: SizedBox(
                  width: screenWidth * 0.35,
                  child: SvgPicture.asset(
                    "assets/icons/sarang_lebah.svg",
                    colorFilter: const ColorFilter.mode(
                        Color(0xffC77710), BlendMode.srcIn),
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                List<Widget> gridItems = [];
                for (var jar in jars) {
                  gridItems
                      .add(buildJarWidget(context, jar, constraints.maxWidth));
                }
                gridItems.add(
                    buildAddButton(constraints.maxWidth, showAddJarDialog));

                List<List<Widget>> shelfRows = [];
                for (int i = 0; i < gridItems.length; i += 3) {
                  shelfRows.add(gridItems.sublist(
                      i, i + 3 > gridItems.length ? gridItems.length : i + 3));
                }

                if (shelfRows.length < 3) {
                  int missingShelves = 3 - shelfRows.length;
                  for (int i = 0; i < missingShelves; i++) {
                    shelfRows.add([]);
                  }
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Center(
                        child: Text(
                          "Honey Jar Chart",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ...shelfRows.map((rowItems) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 65),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: buildShelf(),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                margin: const EdgeInsets.only(bottom: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: rowItems.map((item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: item,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
