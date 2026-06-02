import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [

            // Honeycomb Background
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // HEADER
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

                  const SizedBox(height: 20),

                  // FOTO PROFILE
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFECC488),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE28A24),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // NAME
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PASSWORD
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden =
                                !isPasswordHidden;
                          });
                        },
                        icon: SvgPicture.asset(
                          isPasswordHidden
                              ? "assets/icons/eye_closed.svg"
                              : "assets/icons/eye_line.svg",
                          width: 22,
                          height: 22,
                          color: Color(0xFFE28A24  ),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // EMAIL
                  const Text(
                    "Email address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFFE28A24),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // LOGOUT
                  GestureDetector(
                    onTap: () {
                      // TODO: logout
                    },
                    child: const Row(
                      children: [

                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),

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

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}