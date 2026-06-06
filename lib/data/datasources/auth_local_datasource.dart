// khusus buat handle sesuatu yang disimpen dipenyimpanan hp,
// contohnya token, data user atau lainnya. disini penyimpanan lokal pake
// shared preferences, tapi bisa juga pake yang lain seperti Hive, Sqflite, dll
// shared preferences => menyimpan data lokal dihp atau penyimpanan data kecil
// (token, sesi login)
// sifatnya presisten (data tetep ada walaupun aplikasi ditutup)

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nabee/data/model/response/login_response_model.dart';

class AuthLocalDatasource {
  // buat simpen data yg login
  Future<void> saveAuthData(LoginResponseModel data) async {
    // ambil instance dari hsared preferences, kaya buka lemari
    // buat nyimpen barang
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', data.toJson());
  }

  // remove data yg login
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
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
}
