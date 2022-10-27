import 'package:flutter/material.dart';

import '../widgets/home/fondoHome.dart';
import 'proyectos_aom.dart';

class ListaProyectosAomPage extends StatelessWidget {
  const ListaProyectosAomPage();

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      body: const ProyectsoContenidoAOMState(),
      showMenuButton: true,
    );
  }
}
