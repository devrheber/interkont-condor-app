import 'package:shared_preferences/shared_preferences.dart';

void logout()
async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setInt('estadoLogin', null);
  await prefs.clear();
  await prefs.setString('listProyectosSeleccionados', '[]');
  // await prefs.setString('contenidoWebService', null);

}