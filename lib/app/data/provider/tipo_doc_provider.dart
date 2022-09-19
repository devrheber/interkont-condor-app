import 'dart:convert';

import 'package:appalimentacion/app/ui/utils/api_routes.dart';
import 'package:appalimentacion/main.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

import '../../../globales/variables.dart';
import '../model/tipo_doc_model.dart';

class TipoDocApi {
  final String _url = urlGlobalApiCondor;

  Future<List<TipoDoc>> getTipoDocWithDio() async {
    final dio = Get.find<Dio>();
    var authorization = contenidoWebService[0]['usuario']['tokenUsu'];

    try {
      var response = await dio.get(
        ApiRoutes.tiposDocumento,
        options: ApiOptions.options(prefs),
      );
      if (response.statusCode == 200) {
        return tipoDocFromJson(json.encode(response.data));
      }
      return [];
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }
}
