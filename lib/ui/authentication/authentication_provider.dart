import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/local/user_preferences.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/login_repository.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider({
    required this.loginRepository,
    required this.prefsRepository,
  }) {
    loadUserData();
  }

  final UserPreferences prefsRepository;
  final LoginRepository loginRepository;

  User? user;

  void loadUserData() {
    final userData = prefsRepository.userData;
    if (userData.isNotEmpty) {
      final userDataSession = jsonDecode(userData);
      user = User(
          username: userDataSession['username'],
          token: userDataSession['user_token']);
    }
  }

  void updateUser(User user) {
    this.user = user;
  }

  Future<bool> logout() async {
    return await prefsRepository.clear();
  }
}
