import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <-- Ini tadi lupa di-import
import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_nabee/ui/home/widget/edit_profile_page.dart';
import 'package:flutter_nabee/ui/home/widget/home_page.dart';
import 'package:flutter_nabee/ui/intro/bloc/login/login_bloc.dart';
import 'package:flutter_nabee/ui/intro/bloc/logout/logout_bloc.dart';
import 'package:flutter_nabee/ui/intro/login_page.dart';
import 'package:flutter_nabee/ui/intro/splash_page.dart';

// Catatan: Pastikan kamu sudah membuat/mengimport file AuthRemoteDatasource & Bloc kamu ya!
// Contoh import block-mu biasanya seperti ini (sesuaikan dengan folder aslimu jika error):
// import 'package:flutter_nabee/data/datasources/auth_remote_datasource.dart';
// import 'package:flutter_nabee/bloc/login/login_bloc.dart'; 
// import 'package:flutter_nabee/bloc/logout/logout_bloc.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDatasource())),
        BlocProvider(create: (context) => LogoutBloc(AuthRemoteDatasource())),
      ], // <-- Menutup daftar providers dengan rapi
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(), // <-- Sekarang posisi home sudah benar di dalam MaterialApp
      ),
    ); // <-- Menutup MultiBlocProvider
  }
}