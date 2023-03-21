import 'package:appalimentacion/constants/api_base_url.dart';
import 'package:appalimentacion/constants/api_routes.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/user.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:dio/dio.dart' as x;

class LoginRemote implements LoginRepository {
  LoginRemote() {
    _init();
  }
  final UserPreferences prefs = UserPreferences();
  final String _url = urlGlobalApiCondor;

  late x.Dio _dio;

  void _init() {
    _dio = x.Dio();
    _dio.options = x.BaseOptions(
      connectTimeout: 15000,
      baseUrl: _url,
      headers: {
        'Content-type': 'application/json',
      },
    );

    // TODO Use interceptors
  }

  @override
  Future<User> login(String username, String password) async {
    try {
      final x.Response<dynamic> response = await _dio.post(
        ApiRoutes.login,
        data: {
          'usuario': username,
          'contrasena': password,
        },
      );

      response;
      User user = User(
        username: username,
        token: response.headers['authorization']![0],
      );

      return user;
    } on x.DioError catch (e) {
      String message = e.response?.data['message'] ??
          e.response?.data['data']['message'] ??
          'Algo salió mal';
      throw LoginException(message);
    } catch (e) {
      throw const LoginException('Algo salió mal');
    }
  }

  @override
  Future<void> logout() async {
    // TODO Handle logout
    throw UnimplementedError();
  }
}
