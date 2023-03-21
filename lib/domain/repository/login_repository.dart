import '../models/models.dart';

abstract class LoginRepository {
  Future<User> login(String username, String password);
  Future<void> logout();
}

class LoginException implements Exception {
  final String message;

  const LoginException(this.message);
}
