import 'package:appalimentacion/domain/models/models.dart';

abstract class LoginRepository {
  Future<User> login(String username, String password);
  Future<void> logout();
}
