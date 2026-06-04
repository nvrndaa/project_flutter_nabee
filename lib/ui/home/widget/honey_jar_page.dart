import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HoneyJarPage extends StatefulWidget {
  const HoneyJarPage({super.key});

  @override
  State<HoneyJarPage> createState() => _HoneyJarPageState();
}

class _HoneyJarPageState extends State<HoneyJarPage> {
  final List<JarModel> jars = [];

  void showAddJarDialog() {
    final nameController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    final priceController = TextEditingController();

    String notification = "Daily";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      const Text(
                        "Make New Jar",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildField("Nama", nameController),

                      const SizedBox(height: 12),

                      buildField("Start", startController),

                      const SizedBox(height: 12),

                      buildField("End", endController),

                      const SizedBox(height: 12),

                      buildField("Rp.", priceController),

                      const SizedBox(height: 12),

                      DropdownButtonFormField(
                        value: notification,
                        decoration: inputDecoration("Choose"),
                        items: const [
                          DropdownMenuItem(
                            value: "Daily",
                            child: Text("Daily"),
                          ),
                          DropdownMenuItem(
                            value: "Weekly",
                            child: Text("Weekly"),
                          ),
                          DropdownMenuItem(
                            value: "Monthly",
                            child: Text("Monthly"),
                          ),
                        ],
                        onChanged: (value) {
                          setDialogState(() {
                            notification = value!;
                          });
                        },
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
                          ),
                          onPressed: () {
                            setState(() {
                              jars.add(
                                JarModel(
                                  name: nameController.text,
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
                            style: TextStyle(color: Colors.white),
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

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Color(0xffE38D1A)),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    );
  }

  Widget buildField(String hint, TextEditingController controller) {
    return TextField(controller: controller, decoration: inputDecoration(hint));
  }

  Widget shelf() {
    return Stack(
      children: [
        Container(
          height: 45,
          width: 412,
          decoration: BoxDecoration(
            color: const Color(0xffDA8F43),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 15,
            width: 412,
            decoration: BoxDecoration(
              color: const Color(0xffBA601F),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget jarWidget(JarModel jar) {
  return Column(
    // Tambahkan baris ini agar isi toples dan teksnya rapat ke bawah menempel rak
    mainAxisAlignment: MainAxisAlignment.end, 
    children: [
      SizedBox(height: 95, child: Image.asset("assets/images/empty_jar.png")),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        color: const Color(0xffF7E6A6),
        child: Text(
          jar.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

  Widget addButton() {
    return GestureDetector(
      onTap: showAddJarDialog,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xffE9D4BC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/plus.svg",
            width: 35,
            height: 35,
            color: Color(0xffB66A0D),
          ),
        ),
      ),
    );
  }

  Widget _navItem({required String icon, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon, width: 24, height: 24),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: .3, // Lebih terlihat dari .2
                child: SizedBox(
                  width: 140,
                  child: SvgPicture.asset(
                    "icons/sarang_lebah.svg",
                    // Gunakan warna emas hangat agar terlihat jelas di BG putih
                    color: const Color(0xffC77710),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 50),

                const Center(
                  child: Text(
                    "Honey Jar Chart",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  height: 140, // Tetap sama
                  child: Row(
                    // Tambahkan baris ini agar semua item di dalam Row menempel ke bawah (ke arah rak)
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 20),

                      ...jars
                          .take(2)
                          .map(
                            (jar) => Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: jarWidget(jar),
                            ),
                          ),

                      addButton(),
                    ],
                  ),
                ),

                shelf(),

                const SizedBox(height: 155),

                shelf(),

                const SizedBox(height: 155),

                shelf(),

                const Spacer(),

                Container(
                  margin: const EdgeInsets.all(20),
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffC77710),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem(
                        icon: "assets/icons/nav/home.svg",
                        label: "Home",
                      ),
                      _navItem(
                        icon: "assets/icons/nav/honey_jar.svg",
                        label: "Honey Jar",
                      ),
                      _navItem(
                        icon: "assets/icons/nav/profile.svg",
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
