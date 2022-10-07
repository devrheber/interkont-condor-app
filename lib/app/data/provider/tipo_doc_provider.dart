import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/app/ui/utils/api_routes.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:dio/dio.dart';

import '../../../globales/variables.dart';
import '../model/tipo_doc_model.dart';

class TipoDocApi {
  final String _url = urlGlobalApiCondor;

  UserPreferences prefs = UserPreferences();

  Future<List<TipoDoc>> getTipoDoc() async {
    HttpClient client = HttpClient();

    final user = User.fromJson(json.decode(prefs.userData));

    HttpClientRequest request =
        await client.getUrl(Uri.parse(_url + ApiRoutes.tiposDocumento));
    String authorization = user.token;
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
      final user = User.fromJson(json.decode(prefs.userData));
      String authorization = user.token;

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
