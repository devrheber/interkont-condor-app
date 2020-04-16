import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/listaProyectos/proyectos.dart';
import 'package:appalimentacion/widgets/home/fondoHome.dart';
import 'package:flutter/material.dart';

class ListaProyectos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FondoHome(
      contenido: ProyectosContenido(),
      bottomNavigationBar: true,
      contenidoBottom: null
    );
  }
}