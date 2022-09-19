import 'dart:convert';

import 'package:appalimentacion/app/data/model/datos_alimentacion_model.dart';
import 'package:appalimentacion/app/ui/utils/api_routes.dart';
import 'package:appalimentacion/main.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class DatosAlimentacionApi {
  final dio = Get.find<Dio>();
  Future<Map<String, dynamic>> datosAlimentacion(int codigoProyecto) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    try {
      var response = await dio.post(
        ApiRoutes.vistaListaConsulta,
        data: {'codigoProyecto': codigoProyecto},
        options: ApiOptions.options(prefs),
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
      data['statusCode'] = response.statusCode;
      data['message'] = 'Éxito';
      data['data'] = datosAlimentacionFromJson(json.encode(response.data));
      data['success'] = true;

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
        'success': false,
      };
    }
  }
}
