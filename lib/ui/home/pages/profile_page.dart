import 'package:flutter/material.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/datasources/profile_remote_datasource.dart';
import 'package:flutter/src/widgets/framework.dart'; // Diperlukan jika ada dependensi state standar
import 'package:flutter_nabee/ui/home/pages/home_page.dart';
import 'package:flutter_nabee/ui/home/pages/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/pages/edit_profile_page.dart';
// TODO: Silakan sesuaikan path import halaman notification & login di bawah ini
import 'package:flutter_nabee/ui/home/pages/setting_notification.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 2;
  String _userName = '';
  String _userEmail = '';
  String _avatarUrl = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await AuthLocalDatasource().getUserName();
    final email = await AuthLocalDatasource().getUserEmail();
    final avatar = await AuthLocalDatasource().getAvatarUrl();
    if (!mounted) return;
    setState(() {
      _userName = name;
      _userEmail = email;
      _avatarUrl = avatar;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, maxWidth: 512);
    if (picked == null) return;

    setState(() => _isLoading = true);

    final result =
        await ProfileRemoteDatasource().updateAvatar(picked.path);
    if (!mounted) return;
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        setState(() => _isLoading = false);
      },
      (_) async {
        final avatar = await AuthLocalDatasource().getAvatarUrl();
        if (!mounted) return;
        setState(() {
          _avatarUrl = avatar;
          _isLoading = false;
        });
      },
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pilih Foto Profil',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFE28A24)),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFFE28A24)),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi popup konfirmasi sebelum Logout
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin keluar dari akun ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // TODO: Tambahkan fungsi hapus session/token Anda di sini jika ada, contoh:
              // await AuthLocalDatasource().clearSession(); 
              
              if (!mounted) return;
              // Arahkan kembali ke halaman login dan hapus tumpukan navigasi terdahulu
              // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text("Keluar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
            GestureDetector(
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
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
              onTap: () {},
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
              top: -10,
              right: -10,
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  "assets/images/sarang_lebah_atas.png",
                  width: screenWidth * 0.30,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // ================= SEKSI UTAMA PROFIL ATAS =================
                  GestureDetector(
                    onTap: _isLoading ? null : _showImagePicker,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF0A243).withAlpha(102),
                        border: Border.all(
                          color: const Color(0xFFE28A24),
                          width: 3,
                        ),
                        image: _avatarUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(_avatarUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _avatarUrl.isEmpty
                          ? Center(
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/camera.svg",
                                      width: 45,
                                      height: 45,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E1F0F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userEmail,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 160,
                    height: 38,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfilePage()),
                        ).then((_) => _loadUserData());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE28A24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // =========================================================

                  const SizedBox(height: 28),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Character Level",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1C2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF5CD143),
                              width: 2.5,
                            ),
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                "assets/images/ulet_happy.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Caterpillar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4E1F0F),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/satu.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  Expanded(
                                    child: Transform.translate(
                                      offset: const Offset(-3, 0),
                                      child: Container(
                                        height: 14,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFD3A273),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.zero,
                                            bottomLeft: Radius.zero,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/dua.svg",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "account settings",
                      style: TextStyle(
                        color: Color(0xFF4E1F0F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Menampilkan langsung tile Notifications tanpa tile Setting sebelumnya
                  _settingTile(
                    "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationSettingsPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // ================= TOMBOL LOGOUT SEBELAH KANAN =================
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _showLogoutDialog,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      icon: const Icon(Icons.logout, color: Colors.redAccent, size: 20),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingTile(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF4E1F0F),
                fontSize: 15,
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFF4E1F0F), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String icon, String label, bool active) {
    final Color itemColor = active ? Colors.white : const Color(0xFF5C3818);
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