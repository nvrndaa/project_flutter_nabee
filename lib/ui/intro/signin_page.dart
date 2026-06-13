import 'package:flutter/material.dart';
import 'package:flutter_nabee/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_nabee/data/model/request/register_request_model.dart';
import 'package:flutter_nabee/ui/home/pages/reward_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _authRemoteDatasource = AuthRemoteDatasource();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final request = RegisterRequestModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    final response = await _authRemoteDatasource.register(request);

    if (!mounted) return;

    response.fold(
      (error) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      (data) async {
        await AuthLocalDatasource().saveAuthData(data);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RewardPage()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          Positioned(
            top: -10,
            left: -10,
            child: Image.asset(
              'assets/images/sarang_lebah_atas.png',
              width: 180,
            ),
          ),
          Positioned(
            bottom: -30,
            right: -20,
            child: Image.asset(
              'assets/images/sarang_lebah_bawah.png',
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 110),
                    const Text(
                      'Lets start your new journey!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4E1F0F),
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Name', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 18),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 18),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: SvgPicture.asset(
                            _obscurePassword
                                ? 'assets/icons/eye_closed.svg'
                                : 'assets/icons/eye_line.svg',
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFE28A24),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: _inputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: SvgPicture.asset(
                            _obscureConfirmPassword
                                ? 'assets/icons/eye_closed.svg'
                                : 'assets/icons/eye_line.svg',
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFE28A24),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE28A24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 18),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 130),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFFE28A24), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFFE28A24), width: 2),
      ),
    );
  }
}
