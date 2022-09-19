import 'package:appalimentacion/app/data/provider/login_provider.dart';
import 'package:get/instance_manager.dart';

class LoginService {
  final LoginApi _api = Get.find<LoginApi>();
  Future<Map<String, dynamic>> login({String usuario, String contrasena}) =>
      _api.login(usuario, contrasena);
}
