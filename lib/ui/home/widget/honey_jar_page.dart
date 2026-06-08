import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/home/widget/home_page.dart';
import 'package:flutter_nabee/ui/home/widget/honey_calender_page.dart';
import 'package:flutter_nabee/ui/home/widget/profile_page.dart';
// Pastikan path import di bawah ini disesuaikan dengan struktur folder proyek Anda 
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneyJarPage extends StatefulWidget {
  const HoneyJarPage({super.key});

  @override
  State<HoneyJarPage> createState() => _HoneyJarPageState();
}

class _HoneyJarPageState extends State<HoneyJarPage> {
  final List<JarModel> jars = [];
  int selectedIndex = 1; // Honey Jar aktif di index 1

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
                            color: Color(0xff4E1F0F),
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
                            buildDateField(controller: startController, hint: "Start"),
                            const SizedBox(height: 8),
                            buildDateField(controller: endController, hint: "End"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      buildFormGroup("Price", buildField("Rp.", priceController)),
                      const SizedBox(height: 12),
                      
                      buildFormGroup(
                        "Notification",
                        DropdownButtonFormField<String>(
                          value: notification == "Choose" ? null : notification,
                          hint: const Text("Choose", style: TextStyle(color: Colors.grey, fontSize: 14)),
                          decoration: inputDecoration(""),
                          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xffE38D1A)),
                          items: const [
                            DropdownMenuItem(value: "3x", child: Text("3 times")),
                            DropdownMenuItem(value: "5x", child: Text("5 times")),
                            DropdownMenuItem(value: "7x", child: Text("7 times")),
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
                            backgroundColor: const Color(0xffE38D1A),
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
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
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

  Widget buildFormGroup(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xff4E1F0F),
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xffE38D1A), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xffE38D1A), width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget buildField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller, 
      decoration: inputDecoration(hint),
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget buildDateField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      style: const TextStyle(fontSize: 15),
      decoration: inputDecoration(hint).copyWith(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            "assets/icons/calender.svg",
            width: 18,
            height: 18,
            color: AppColors.orange,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.calendar_today_outlined, color: AppColors.orange, size: 18),
          ),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2024),
          lastDate: DateTime(2035),
        );

        if (pickedDate != null) {
          setState(() {
            controller.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  Widget shelf() {
    return Stack(
      children: [
        Container(
          height: 35,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  // PERBAIKAN: Menambahkan GestureDetector agar item toples dapat merespon sentuhan klik
  Widget jarWidget(JarModel jar, double availableWidth) {
    double jarWidth = (availableWidth - 80) / 3;
    if (jarWidth > 90) jarWidth = 90;

    return GestureDetector(
      onTap: () {
        // Berpindah ke halaman HoneyCalendarPage dengan membawa data toples yang dipilih
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HoneyCalendarPage(jar: jar),
          ),
        );
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
                  const Icon(Icons.liquor, size: 50, color: Color(0xffE38D1A)),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: jarWidth + 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            color: const Color(0xffF7E6A6),
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

  Widget addButton(double availableWidth) {
    double btnSize = (availableWidth - 80) / 3;
    if (btnSize > 80) btnSize = 80;

    return GestureDetector(
      onTap: showAddJarDialog,
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(
          color: const Color(0xffE9D4BC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/plus.svg",
            width: btnSize * 0.4,
            height: btnSize * 0.4,
            colorFilter:
                const ColorFilter.mode(Color(0xffB66A0D), BlendMode.srcIn),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.add, color: Color(0xffB66A0D)),
          ),
        ),
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
            BlendMode.srcIn,
          ),
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    double shelfGap = screenHeight * 0.14;
    if (shelfGap > 130) shelfGap = 130;

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: _navItem("assets/icons/nav/home.svg", "Home", selectedIndex == 0),
            ),
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 1);
              },
              child: _navItem("assets/icons/nav/honey_jar.svg", "Honey jar", selectedIndex == 1),
            ),
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
              child: _navItem("assets/icons/nav/profile.svg", "Profile", selectedIndex == 2),
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
                      SizedBox(height: shelfGap * 0.4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ...jars.take(2).map(
                                        (jar) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: jarWidget(
                                              jar, constraints.maxWidth),
                                        ),
                                      ),
                                  if (jars.length < 2)
                                    addButton(constraints.maxWidth),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      shelf(),
                      SizedBox(height: shelfGap),
                      shelf(),
                      SizedBox(height: shelfGap),
                      shelf(),
                      const SizedBox(height: 30),
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