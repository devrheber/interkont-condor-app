
import 'package:appalimentacion/globales/variables.dart';

calcularValorEjecutado()
{
  var nuevoValorEjecutado = 0.0;
  var nuevoPorcentajeValorJecutado = 0.0;

  for(int cont=0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'].length; cont++)
  {
    nuevoValorEjecutado = nuevoValorEjecutado + contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado'];
  }
  nuevoPorcentajeValorJecutado = nuevoValorEjecutado/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'];

  contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado'] = nuevoPorcentajeValorJecutado;

}