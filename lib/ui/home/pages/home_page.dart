import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/datasources/honey_jar_remote_datasource.dart';
import 'package:flutter_nabee/ui/home/bloc/article/article_bloc.dart';
import 'package:flutter_nabee/ui/home/pages/honey_calendar_page.dart';
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
  String _greetingName = "";
  String _characterName = "";
  int selectedIndex = 0;
  List<JarModel> _jars = [];
  int _totalSaved = 0;
  int _targetSolved = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadJars();
  }

  Future<void> _loadUserData() async {
    try {
      final email = await AuthLocalDatasource().getUserEmail();
      final petName = await AuthLocalDatasource().getPetName();
      if (!mounted) return;
      String greeting = email;
      final atIndex = greeting.indexOf('@');
      if (atIndex > 0) greeting = greeting.substring(0, atIndex);
      setState(() {
        _greetingName = greeting;
        _characterName = petName;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _greetingName = '';
          _characterName = '';
        });
      }
    }
  }

  Future<void> _loadJars() async {
    final result = await HoneyJarRemoteDatasource().fetchHoneyJars();
    if (!mounted) return;
    result.fold(
      (_) {},
      (jars) {
        final list = jars.map((r) => JarModel.fromResponse(r)).toList();
        final saved = jars.fold<int>(
            0, (sum, j) => sum + (int.tryParse(j.currentAmount) ?? 0));
        final solved = jars.where((j) => j.isCompleted).length;
        setState(() {
          _jars = list;
          _totalSaved = saved;
          _targetSolved = solved;
        });
      },
    );
  }

  void _showEditNameDialog() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => EditNameDialog(currentName: _characterName),
    );

    if (newName != null && mounted) {
      await AuthLocalDatasource().savePetName(newName);
      setState(() {
        _characterName = newName;
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
            Positioned(
              top: 0,
              right: 0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset("assets/images/sarang_lebah_atas.png",
                    width: 140),
              ),
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification ||
                    notification is UserScrollNotification) {
                  final metrics = notification.metrics;
                  if (metrics.pixels >= metrics.maxScrollExtent - 300) {
                    context
                        .read<ArticleBloc>()
                        .add(const ArticleEvent.fetchMoreArticles());
                  }
                }
                return false;
              },
              child: SingleChildScrollView(
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
                    if (_jars.isNotEmpty) ...[
                      _buildNearestTargetSection(),
                      const SizedBox(height: 25),
                    ],
                    const HoneyTipsSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _greetingName.isEmpty ? "Hi!" : "Hi, $_greetingName!",
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
    final moneySaved = _totalSaved >= 1000000
        ? 'Rp ${(_totalSaved / 1000000).toStringAsFixed(1)} JT'
        : 'Rp $_totalSaved';
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: "assets/icons/target_salved.svg",
            title: "Target solved",
            value: "$_targetSolved Jars",
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: "assets/icons/coin.svg",
            title: "Money saved",
            value: moneySaved,
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
          Transform(
            transform: Matrix4.identity()
              ..scale(1.8) // Mengatur tingkat perbesaran ulat (Zoom)
              ..translate(
                  0.0, 14.5), // Menggeser posisi ulat ke bawah (koordinat Y)
            alignment: Alignment.center,
            child: Image.asset(
              "assets/gif/Caterpillar_Happy.gif",
              height: 180,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showEditNameDialog,
            child: SizedBox(
              width: 140,
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xffEBB700),
                          width: 3.0,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            _characterName.isEmpty ? "Name" : _characterName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4E1F0F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -6,
                    right: 10,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffEBB700),
                          width: 2.0,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit,
                          size: 12,
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
    final sorted = List<JarModel>.from(_jars)
      ..sort((a, b) {
        final aDate = DateTime.tryParse(a.endDate) ?? DateTime(9999);
        final bDate = DateTime.tryParse(b.endDate) ?? DateTime(9999);
        return aDate.compareTo(bDate);
      });
    final nearest = sorted.isNotEmpty ? sorted.first : null;
    if (nearest == null) return const SizedBox.shrink();

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
        _buildJarCard(nearest),
      ],
    );
  }

  Widget _buildJarCard(JarModel jar) {
    final target = int.tryParse(jar.price) ?? 1;
    final current = int.tryParse(jar.currentAmount) ?? 0;
    final progress = (current / target).clamp(0.0, 1.0);
    final percent = (progress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HoneyCalendarPage(jar: jar)),
          );
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color(0xFFFDE674),
            borderRadius: BorderRadius.circular(24),
          ),
          child: SizedBox(
            height: 105,
            child: Stack(
              children: [
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
                Positioned(
                  left: 107,
                  right: 16,
                  top: 14,
                  bottom: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Text(
                        jar.endDate,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6D5333),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: progress,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFCC00),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "$percent% saved",
                              style: const TextStyle(
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
