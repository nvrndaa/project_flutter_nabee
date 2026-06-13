// khusus buat handle sesuatu yang disimpen dipenyimpanan hp,
// contohnya token, data user atau lainnya. disini penyimpanan lokal pake
// shared preferences, tapi bisa juga pake yang lain seperti Hive, Sqflite, dll
// shared preferences => menyimpan data lokal dihp atau penyimpanan data kecil
// (token, sesi login)
// sifatnya presisten (data tetep ada walaupun aplikasi ditutup)

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nabee/data/model/response/login_response_model.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(LoginResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', data.toJson());
    if (data.user?.email != null) {
      await pref.setString('user_email', data.user!.email!);
    }
    if (data.user?.name != null) {
      await pref.setString('user_name', data.user!.name!);
    }
    if (data.user?.avatar != null) {
      await pref.setString('user_avatar', data.user!.avatar!);
    }
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
    await pref.remove('user_email');
    await pref.remove('user_avatar');
    await pref.remove('user_name');
  }

  // ambil data yg login
  Future<LoginResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return LoginResponseModel.fromJson(data);
    } else {
      throw Exception('Data auth tidak ditemukan');
    }
  }

  // cek apakah user sudah login atau belum
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }

  Future<void> savePetName(String name) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('pet_name', name);
  }

  Future<String> getPetName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('pet_name') ?? '';
  }

  Future<void> saveAvatarUrl(String url) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('user_avatar', url);
  }

  Future<String> getAvatarUrl() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('user_avatar') ?? '';
  }

  Future<String> getUserName() async {
    final pref = await SharedPreferences.getInstance();
    final savedName = pref.getString('user_name');
    if (savedName != null && savedName.isNotEmpty) return savedName;
    final data = pref.getString('auth_data');
    if (data == null) return '';
    try {
      final map = json.decode(data) as Map<String, dynamic>;
      final user = map['user'] as Map<String, dynamic>?;
      if (user == null) return '';
      final name = user['name'] as String? ?? '';
      if (name.isNotEmpty) {
        await pref.setString('user_name', name);
      }
      return name;
    } catch (_) {
      return '';
    }
  }

  Future<String> getUserEmail() async {
    final pref = await SharedPreferences.getInstance();
    final savedEmail = pref.getString('user_email');
    if (savedEmail != null && savedEmail.isNotEmpty) return savedEmail;
    final data = pref.getString('auth_data');
    if (data == null) return '';
    try {
      final map = json.decode(data) as Map<String, dynamic>;
      final user = map['user'] as Map<String, dynamic>?;
      if (user == null) return '';
      final email = user['email'] as String? ?? '';
      if (email.isNotEmpty) {
        await pref.setString('user_email', email);
      }
      return email;
    } catch (_) {
      return '';
    }
  }
}
