import 'package:appalimentacion/app/ui/utils/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../../../main.dart';

class LoginApi {
  final dio = Get.find<Dio>();
  Future<Map<String, dynamic>> login(String usuario, String contrasena) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    try {
      var response = await dio.post(
        ApiRoutes.login,
        data: {'usuario': usuario, 'contrasena': contrasena},
      );
      if (response.statusCode == 200) {
        prefs.token = response.headers['authorization'].first;
        prefs.nombreUsu = usuario;
      }
      data['statusCode'] = response.statusCode;
      data['message'] = response.data;
      return data;
    } on DioError catch (e) {
      const String checkInternetMessage =
          '\nRevise su conexión\n a Internet y vuelva a intentarlo.';
      return <String, dynamic>{
        'message': e.type.name == 'other'
            ? checkInternetMessage
            : e.type.name == 'connectTimeout'
                ? '\nSe acabo el tiempo de espera. $checkInternetMessage'
                : '\nLo sentimos\nel usuario o la contraseña es incorrecta',
        'statusCode': e.response?.statusCode ?? 0,
      };
    }
  }
}
