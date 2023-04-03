import 'package:appalimentacion/domain/models/user.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';

class LoginLocalImpl implements LoginRepository {
  @override
  Future<User> login(String username, String password) async {
    User user = User(username: username, token: 'token-test');

    return user;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
