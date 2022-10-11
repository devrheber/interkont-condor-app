import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';
import 'proyectos.dart';

class ListaProyectos extends StatelessWidget {
  const ListaProyectos();

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      body: ProyectosContenido(),
      bottomNavigationBar: null,
      primeraPagina: true,
    );
  }
}
