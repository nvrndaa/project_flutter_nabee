import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/datasources/honey_jar_remote_datasource.dart';
import 'package:flutter_nabee/ui/home/pages/home_page.dart';
import 'package:flutter_nabee/ui/home/widget/honey_shelf_widget.dart';
import 'package:flutter_nabee/ui/home/pages/profile_page.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HoneyJarPage extends StatefulWidget {
  const HoneyJarPage({super.key});

  @override
  State<HoneyJarPage> createState() => _HoneyJarPageState();
}

class _HoneyJarPageState extends State<HoneyJarPage> {
  int selectedIndex = 1;
  List<JarModel> _jars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJars();
  }

  Future<void> _loadJars() async {
    setState(() => _isLoading = true);
    final result = await HoneyJarRemoteDatasource().fetchHoneyJars();
    if (!mounted) return;
    result.fold(
      (error) => setState(() => _isLoading = false),
      (jars) => setState(() {
        _jars = jars.map((r) => JarModel.fromResponse(r)).toList();
        _isLoading = false;
      }),
    );
  }

  void showAddJarDialog() {
    final List<String> notificationOptions = ['3 times', '5 times', '7 times'];
    String? localSelectedNotification;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    Future<void> selectDate(
        BuildContext ctx, TextEditingController controller) async {
      final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffE38D1A),
                onPrimary: Colors.white,
                onSurface: Color(0xff1A1A1A),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      }
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 290,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        const Center(
                          child: Text(
                            "Make New Jar",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1A1A1A)),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // FIELD 1: Nama
                        const Text(
                          "Nama",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1A1A1A)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 42,
                          child: TextField(
                            controller: nameController,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xff1A1A1A)),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A), width: 1.5)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // FIELD 2: Date (Awal)
                        const Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1A1A1A)),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => selectDate(context, startDateController),
                          child: AbsorbPointer(
                            child: SizedBox(
                              height: 42,
                              child: TextField(
                                controller: startDateController,
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xff1A1A1A)),
                                decoration: InputDecoration(
                                  hintText: "Start",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  suffixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: AppColors.orange,
                                      size: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE38D1A))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE38D1A))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // FIELD 3: Date (Akhir)
                        GestureDetector(
                          onTap: () => selectDate(context, endDateController),
                          child: AbsorbPointer(
                            child: SizedBox(
                              height: 42,
                              child: TextField(
                                controller: endDateController,
                                style: const TextStyle(
                                    fontSize: 13, color: Color(0xff1A1A1A)),
                                decoration: InputDecoration(
                                  hintText: "End",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  suffixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: AppColors.orange,
                                      size: 20),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE38D1A))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          color: Color(0xffE38D1A))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // FIELD 4: Price
                        const Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1A1A1A)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 42,
                          child: TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xff1A1A1A)),
                            decoration: InputDecoration(
                              // FIX: Pakai hintText biar tulisan "Rp." udah ada dari awal sebelum dipencet
                              hintText: "Rp. ",
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 13),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: Color(0xffE38D1A), width: 1.5)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // FIELD 5: Notification
                        const Text(
                          "Notification",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1A1A1A)),
                        ),
                        const SizedBox(height: 6),

                        // DROPDOWN DENGAN GARIS MENTOK KANAN KIRI SEJAJAR 100%
                        Builder(builder: (buttonContext) {
                          return GestureDetector(
                            onTap: () {
                              final RenderBox renderBox =
                                  buttonContext.findRenderObject() as RenderBox;
                              final position =
                                  renderBox.localToGlobal(Offset.zero);

                              showMenu<String>(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                  position.dx + (renderBox.size.width - 85),
                                  position.dy + renderBox.size.height,
                                  position.dx + renderBox.size.width,
                                  position.dy + renderBox.size.height + 150,
                                ),
                                elevation: 0,
                                // FIX: Mengunci bodi luar berukuran lebar 85 agar presisi
                                constraints: const BoxConstraints(
                                  maxWidth: 85,
                                  minWidth: 85,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(
                                      color: Color(0xffE38D1A), width: 1.5),
                                ),
                                color: Colors.white,
                                items: notificationOptions.map((String value) {
                                  final bool isLast =
                                      value == notificationOptions.last;
                                  return PopupMenuItem<String>(
                                    value: value,
                                    height: 35,
                                    padding: EdgeInsets
                                        .zero, // Hapus padding item internal
                                    child: Container(
                                      // FIX: Dilepas ukuran width statisnya, diganti alignment biar ditarik melar mentok kanan-kiri kotak luar
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: isLast
                                            ? null
                                            : const Border(
                                                bottom: BorderSide(
                                                    color: Color(0xffE38D1A),
                                                    width: 1),
                                              ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff1A1A1A),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ).then((String? newValue) {
                                if (newValue != null) {
                                  setDialogState(() {
                                    localSelectedNotification = newValue;
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: const Color(0xffE38D1A), width: 1.5),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    localSelectedNotification ?? 'Choose',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: localSelectedNotification == null
                                            ? Colors.grey
                                            : const Color(0xff1A1A1A)),
                                  ),
                                  const Icon(Icons.keyboard_arrow_up_rounded,
                                      color: Colors.grey, size: 22),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 24),

                        // BUTTON SAVE
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffE38D1A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
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
              fontSize: 12),
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
                if (_isLoading) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.orange));
                }

                final rowAvailable = constraints.maxWidth - 48;
                List<Widget> gridItems = [];
                for (var jar in _jars) {
                  gridItems.add(buildJarWidget(context, jar, rowAvailable));
                }
                gridItems.add(buildAddButton(rowAvailable, showAddJarDialog));

                List<List<Widget>> shelfRows = [];
                for (int i = 0; i < gridItems.length; i += 3) {
                  List<Widget> rowItems = gridItems.sublist(
                      i, i + 3 > gridItems.length ? gridItems.length : i + 3);
                  while (rowItems.length < 3) {
                    rowItems.add(const Expanded(child: SizedBox.shrink()));
                  }
                  shelfRows.add(rowItems);
                }

                if (shelfRows.length < 3) {
                  int missingShelves = 3 - shelfRows.length;
                  for (int i = 0; i < missingShelves; i++) {
                    shelfRows.add([
                      const Expanded(child: SizedBox.shrink()),
                      const Expanded(child: SizedBox.shrink()),
                      const Expanded(child: SizedBox.shrink()),
                    ]);
                  }
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Center(
                        child: Text("Honey Jar Chart",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700)),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: rowItems,
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
