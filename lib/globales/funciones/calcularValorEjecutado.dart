import 'package:appalimentacion/domain/models/models.dart';

import '../variables.dart';

calcularValorEjecutado()
{
  var nuevoValorEjecutado = 0.0;
  var nuevoPorcentajeValorJecutado = 0.0;

  for(int cont=0; cont < contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'].length; cont++)
  {
    nuevoValorEjecutado = nuevoValorEjecutado + contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][cont]['valorEjecutado'];
  }
  nuevoPorcentajeValorJecutado = (nuevoValorEjecutado/contenidoWebService[0]['proyectos'][posListaProySelec]['valorproyecto'])*100;
  // nuevoPorcentajeValorJecutado = nuevoPorcentajeValorJecutado.round();
  contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['porcentajeValorEjecutado'] = nuevoPorcentajeValorJecutado;
  contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['nuevoValorEjecutado'] = nuevoValorEjecutado;
}

calculateExecutedValue() {
  // Temp
  Project project;
  List<Actividad> activities;
  ProjectCache cache;

  double newExecutedValue = 0.0;
  double newExecutedPorcentageValue = 0.0;

  for(int i = 0; i < activities.length; i++) {
    newExecutedValue += activities[i].valorEjecutado;
  }
  newExecutedPorcentageValue = (newExecutedValue / project.valorejecutado) * 100;
  cache = cache.copyWith(porcentajeValorEjecutado:  newExecutedPorcentageValue,
  newExecutedValue: newExecutedValue,
  );
  
}