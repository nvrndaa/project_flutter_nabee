import 'package:flutter/material.dart';
import 'package:flutter_nabee/ui/home/widget/home_page.dart';
import 'package:flutter_nabee/ui/home/widget/home_page_login.dart';
import 'package:flutter_nabee/ui/home/widget/honey_calender_page.dart';
import 'package:flutter_nabee/ui/home/widget/honey_jar_page.dart';
import 'package:flutter_nabee/ui/home/widget/notification_page.dart';
import 'package:flutter_nabee/ui/home/widget/profile_page.dart';
import 'package:flutter_nabee/ui/home/widget/setting_notification.dart';
import 'package:flutter_nabee/ui/home/widget/ulet_popup2.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';
import 'package:flutter_nabee/ui/intro/splash_page.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}