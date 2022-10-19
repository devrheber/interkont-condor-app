import 'dart:convert';

import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.prefs, required this.loginRepository}) {
    getUserCredentials();
  }

  final LoginRepository loginRepository;
  final UserPreferences prefs;

  Map<String, dynamic> userDataSession = {};

  bool loading = false;
  int? estadoLogin;

  Future<void> getUserCredentials() async {
    final userData = prefs.userData;
    if (userData.isNotEmpty) {
      userDataSession = jsonDecode(userData);
    }
  }

  Future<User?> login(
      {required String username, required String password}) async {
    estadoLogin = null;
    loading = true;

    notifyListeners();

    try {
      final User user = await loginRepository.login(username, password);
      estadoLogin = 200;
      userDataSession = {
        'username': username,
        'user_token': user.token,
      };
      prefs.userData = jsonEncode(userDataSession);
      return user;
    } catch (_) {
      estadoLogin = 800;
      loading = false;
      notifyListeners();
      return null;
    }
  }
}
