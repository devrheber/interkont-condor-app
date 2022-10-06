import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';

class LoginRemote implements LoginRepository {
  @override
  Future<User> login(String username, String password) async {
    String url = "$urlGlobalApiCondor/login";

    final Map<String, dynamic> body = {
      'usuario': username,
      'contrasena': password,
    };

    try {
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(body)));
      HttpClientResponse response = await request.close();

      var respuesta = await respuestaHttp(response.statusCode);

      if (respuesta == true) {
        // await obtenerListaProyectos();

        User user = User(
            username: username, token: response.headers['authorization'][0]);

        return user;
      } else {
        throw 'Algo salió mal';
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
