import 'package:flutter/material.dart';

import '../widgets/home/fondoHome.dart';
import 'proyectos.dart';

class ListaProyectosPage extends StatelessWidget {
  const ListaProyectosPage();

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      body: ProyectosContenido(),
      bottomNavigationBar: null,
      showMenuButton: true,
    );
  }
}
