import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/widget/home_page.dart';
import 'package:flutter_nabee/ui/home/widget/honey_calender_page.dart';
import 'package:flutter_nabee/ui/home/widget/profile_page.dart';
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

  // --- FUNGSI DIALOG (Sama seperti sebelumnya) ---
  void showAddJarDialog() {
    final nameController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    final priceController = TextEditingController();
    String notification = "Choose";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Make New Jar",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: AppColors.brownText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildFormGroup("Nama", buildField("", nameController)),
                      const SizedBox(height: 12),
                      buildFormGroup(
                        "Date",
                        Column(
                          children: [
                            buildDateField(
                                controller: startController, hint: "Start"),
                            const SizedBox(height: 8),
                            buildDateField(
                                controller: endController, hint: "End"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildFormGroup(
                          "Price", buildField("Rp.", priceController)),
                      const SizedBox(height: 12),
                      buildFormGroup(
                        "Notification",
                        DropdownButtonFormField<String>(
                          value: notification == "Choose" ? null : notification,
                          hint: const Text("Choose",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          decoration: inputDecoration(""),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.orange),
                          items: const [
                            DropdownMenuItem(
                                value: "3x", child: Text("3 times")),
                            DropdownMenuItem(
                                value: "5x", child: Text("5 times")),
                            DropdownMenuItem(
                                value: "7x", child: Text("7 times")),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              notification = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            setState(() {
                              jars.add(
                                JarModel(
                                  name: nameController.text.isEmpty
                                      ? "Jar"
                                      : nameController.text,
                                  startDate: startController.text,
                                  endDate: endController.text,
                                  price: priceController.text,
                                  notification: notification,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildFormGroup(String label, Widget child) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.brownText)),
        const SizedBox(height: 6),
        child
      ]);
  InputDecoration inputDecoration(String hint) => InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.orange, width: 2)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)));
  Widget buildField(String hint, TextEditingController controller) => TextField(
      controller: controller,
      decoration: inputDecoration(hint),
      style: const TextStyle(fontSize: 15));
  Widget buildDateField(
          {required TextEditingController controller, required String hint}) =>
      TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(fontSize: 15),
          decoration: inputDecoration(hint).copyWith(
              suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset("assets/icons/calender.svg",
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                          AppColors.orange, BlendMode.srcIn),
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.orange,
                          size: 18)))),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(2035));
            if (pickedDate != null) {
              setState(() {
                controller.text =
                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              });
            }
          });

  // --- SEGMEN RAK KAYU ---
  Widget shelf() {
    return Stack(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.rakSatu,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.rakDua,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  // --- WIDGET TOPLES (Dibuat lebih turun) ---
  Widget jarWidget(JarModel jar, double availableWidth) {
    double jarWidth = (availableWidth - 80) / 3;
    if (jarWidth > 90) jarWidth = 90;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => HoneyCalendarPage(jar: jar)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: jarWidth * 1.15,
            width: jarWidth,
            child: Image.asset(
              "assets/images/empty_jar.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.liquor, size: 50, color: AppColors.orange),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: jarWidth + 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.softYellow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              jar.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUTTON PLUS (Dibuat ngambang) ---
  Widget addButton(double availableWidth) {
    double btnSize = (availableWidth - 80) / 3;
    if (btnSize > 80) btnSize = 80;

    return GestureDetector(
      onTap: showAddJarDialog,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: btnSize,
            height: btnSize,
            margin: const EdgeInsets.only(
                bottom:
                    40), // Ditambah margin bawah agar posisi kotak plus terlihat agak NGAMBANG ke atas
            decoration: BoxDecoration(
              color: AppColors.buttonPlus,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/plus.svg",
                width: btnSize * 0.6,
                height: btnSize * 0.6,
                colorFilter:
                    const ColorFilter.mode(AppColors.rakDua, BlendMode.srcIn),
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.add, color: AppColors.rakSatu),
              ),
            ),
          ),
          const SizedBox(height: 10), // Placeholder seimbang label teks
        ],
      ),
    );
  }

  Widget _navItem(String icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(
                isActive ? Colors.white : const Color(0xff5C3818),
                BlendMode.srcIn),
            errorBuilder: (context, error, stackTrace) => Icon(
                isActive ? Icons.circle : Icons.circle_outlined,
                color: isActive ? Colors.white : const Color(0xff5C3818),
                size: 22)),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: isActive ? Colors.white : const Color(0xff5C3818),
                fontWeight: FontWeight.bold,
                fontSize: 12)),
      ],
    );
  }

  // --- BUILD UTAMA ---
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
                  gridItems.add(jarWidget(jar, constraints.maxWidth));
                }
                gridItems.add(addButton(constraints.maxWidth));

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

                      // Susunan rak
                      ...shelfRows.map((rowItems) {
                        return Padding(
                          // 1. JARAK ANTAR RAK: Diperjauh dengan menaikkan margin bottom dari 30 ke 65
                          padding: const EdgeInsets.only(bottom: 65),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              // Kayu Rak
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: shelf(),
                              ),
                              // Isi Toples & Tombol Plus
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                // 2. TOPLES KURANG KEBAWAH: Mengurangi margin bottom ke 2 agar nempel pas di atas garis kayu
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
