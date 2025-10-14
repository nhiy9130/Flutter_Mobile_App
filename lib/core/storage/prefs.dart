import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const _kToken = 'auth_token';
  static const _kUser = 'auth_user';

  static Future<void> saveAuth({required String token, required Map<String, dynamic> user}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kToken, token);
    await sp.setString(_kUser, jsonEncode(user));
  }

  static Future<({String? token, Map<String, dynamic>? user})> loadAuth() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(_kToken);
    final userStr = sp.getString(_kUser);
    Map<String, dynamic>? user;
    if (userStr != null) {
      try {
        user = jsonDecode(userStr) as Map<String, dynamic>;
      } catch (_) {}
    }
    return (token: token, user: user);
  }

  static Future<void> clearAuth() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kToken);
    await sp.remove(_kUser);
  }
}



