import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page1.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page2.dart';
import 'package:flutter_nabee/ui/intro/onboarding_page3.dart';
import 'package:flutter_nabee/ui/intro/signin_page.dart';
import 'package:flutter_nabee/ui/intro/splash_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nabee',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}