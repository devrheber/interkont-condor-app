import 'package:appalimentacion/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../widgets/home/fondoHome.dart';
import 'proyectos.dart';

class ListaProyectosPage extends StatelessWidget {
  const ListaProyectosPage._();

  static Route route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: AppRoutes.listaProyectos),
      builder: (_) => const ListaProyectosPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      body: ProyectosContenido.init(),
      bottomNavigationBar: null,
      showMenuButton: true,
    );
  }
}
