import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/ui/intro/bloc/logout/logout_bloc.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isPasswordHidden = true;

  final TextEditingController nameController =
      TextEditingController(text: "Salmaa");

  final TextEditingController passwordController =
      TextEditingController(text: "12345678");

  final TextEditingController emailController =
      TextEditingController(text: "idn2026@gmail.com");

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        state.maybeWhen(
          success: () async {
            await AuthLocalDatasource().removeAuthData();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            }
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -10,
                right: -10,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/sarang_lebah_atas.png",
                    width: 130,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      "Edit profile",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4E1F0F),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 48),
                              ],
                            ),
                            SizedBox(
                                height: screenHeight * 0.03 > 30
                                    ? 30
                                    : screenHeight * 0.03),
                            Center(
                              child: Container(
                                width: screenHeight * 0.11 > 90
                                    ? 90
                                    : screenHeight * 0.11,
                                height: screenHeight * 0.11 > 90
                                    ? 90
                                    : screenHeight * 0.11,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 231, 155, 68),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.orange,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: screenHeight * 0.05 > 40
                                      ? 40
                                      : screenHeight * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: screenHeight * 0.04 > 30
                                    ? 30
                                    : screenHeight * 0.04),
                            const Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(controller: nameController),
                            const SizedBox(height: 20),
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: passwordController,
                              obscureText: isPasswordHidden,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  isPasswordHidden
                                      ? "assets/icons/eye_closed.svg"
                                      : "assets/icons/eye_line.svg",
                                  width: 22,
                                  height: 22,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.orange,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Email address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(controller: emailController),
                            const Expanded(child: SizedBox(height: 30)),
                            GestureDetector(
                              onTap: () {
                                context.read<LogoutBloc>().add(
                                      const LogoutEvent.logout(),
                                    );
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.logout, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text(
                                    "Log out",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColors.orange,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: AppColors.orange,
            width: 2,
          ),
        ),
      ),
    );
  }
}
