import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/app/ui/utils/api_routes.dart';
import 'package:dio/dio.dart';

import '../../../globales/variables.dart';
import '../model/tipo_doc_model.dart';

class TipoDocApi {
  final String _url = urlGlobalApiCondor;

  Future<List<TipoDoc>> getTipoDoc() async {
    HttpClient client = HttpClient();

    HttpClientRequest request =
        await client.getUrl(Uri.parse(_url + ApiRoutes.tiposDocumento));
    String authorization = contenidoWebService[0]['usuario']['tokenUsu'];
    request.headers.set('content-type', 'application/json');
    request.headers.set('Authorization', '$authorization');
    HttpClientResponse response = await request.close();

    try {
      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        return tipoDocFromJson(responseBody);
      }
      return [];
    } on Error catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TipoDoc>> getTipoDocWithDio() async {
    try {
      String authorization = contenidoWebService[0]['usuario']['tokenUsu'];
      Dio dio = Dio();
      var response = await dio.get(_url + ApiRoutes.tiposDocumento,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': '$authorization'
          }));
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
