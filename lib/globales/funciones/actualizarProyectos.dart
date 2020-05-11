
import 'dart:convert';
import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

void actualizarProyectos()
async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List contenidoWebServiceCache;
  List proyectos;
  if(prefs.getString('contenidoWebService') == null){
    
  }else{
    contenidoWebServiceCache = jsonDecode(prefs.getString('contenidoWebService'));
    // contenidoWebServiceCache = contenidoWebServiceCache[0]['proyectos'];
    proyectos = contenidoWebService[0]['proyectos'];

    for(int cont = 0; cont < contenidoWebServiceCache[0]['proyectos'].length; cont++){
      for(int conta = 0; conta < proyectos.length; conta++){
        if(contenidoWebServiceCache[0]['proyectos'][cont]['codigoproyecto'] == proyectos[conta]['codigoproyecto'] && contenidoWebServiceCache[0]['proyectos'][cont]['datos'] != null){
          proyectos[conta]['paso']  = contenidoWebServiceCache[0]['proyectos'][cont]['paso'];
          proyectos[conta]['datos'] = contenidoWebServiceCache[0]['proyectos'][cont]['datos'];
          break;
        }
      }
    }
    contenidoWebService[0]['proyectos']      = proyectos;
    contenidoWebServiceCache[0]['proyectos'] = proyectos;
    await prefs.setString('contenidoWebService', jsonEncode(contenidoWebServiceCache));
  }
}

void actualizarPasosProyecto()
async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List contenidoWebServiceCacheTodo = jsonDecode(prefs.getString('contenidoWebService'));
  List contenidoWebServiceCache = contenidoWebServiceCacheTodo[0]['proyectos'];
  List proyectos = contenidoWebService[0]['proyectos'];

  for(int cont = 0; cont < contenidoWebServiceCache.length; cont++){
    if( contenidoWebServiceCache[cont]['codigoproyecto'] == proyectos[posicionListaProyectosSeleccionado]['codigoproyecto'] ){
      if(contenidoWebServiceCache[cont]['datos'] != null){
        proyectos[posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'] = contenidoWebServiceCache[cont]['datos']['periodoIdSeleccionado'];
        proyectos[posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado'] = contenidoWebServiceCache[cont]['datos']['porcentajeValorProyectadoSeleccionado'];
        proyectos[posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado'] = contenidoWebServiceCache[cont]['datos']['porcentajeValorEjecutado'];
        if(contenidoWebServiceCache[cont]['paso'] >= 1){
          for(int contActividadesCache = 0; contActividadesCache < contenidoWebServiceCache[cont]['datos']['actividades'].length; contActividadesCache++){
            for(int contActividades = 0; contActividades < proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'].length; contActividades++){
              if(proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['actividadId'] ==  contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['actividadId']){

                proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['txtActividadAvance'] = contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance'];

                if(contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance'] != null){
                  
                  proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['cantidadEjecutada'] = double.parse('${proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['cantidadEjecutadaInicial']}') + double.parse('${contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance']}');
                  proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['valorEjecutado'] = double.parse('${proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['cantidadEjecutada']}') * double.parse('${proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['valorUnitario']}');
                  proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['porcentajeAvance'] = double.parse('${proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['valorEjecutado']}') / double.parse('${proyectos[posicionListaProyectosSeleccionado]['datos']['actividades'][contActividades]['valorProgramado']}');

                  calcularValorEjecutado();
                  
                }

                break;

              }
            }              
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 2){
            proyectos[posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'] = contenidoWebServiceCache[cont]['datos']['avancesCualitativos'];
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 3){
            // ACTUALIZAR LOS FACTORES DE ATRASO
            proyectos[posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'] = contenidoWebServiceCache[cont]['datos']['factoresAtrasoSeleccionados'];
            // ACTUALIZAR PASO 3
            for(int contIndicadoresAlcanceCache = 0; contIndicadoresAlcanceCache < contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'].length; contIndicadoresAlcanceCache++ ){
              for(int contIndicadoresAlcance = 0; contIndicadoresAlcance < proyectos[posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'].length; contIndicadoresAlcance++){
                if(proyectos[posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][contIndicadoresAlcance]['indicadorAlcanceId'] == contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'][contIndicadoresAlcanceCache]['indicadorAlcanceId']){
                  proyectos[posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][contIndicadoresAlcance]['txtEjecucionIndicadorAlcance'] = contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'][contIndicadoresAlcanceCache]['txtEjecucionIndicadorAlcance'];
                  break;
                } 
              }
            }
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 4){
            proyectos[posicionListaProyectosSeleccionado]['datos']['txtComentario'] = contenidoWebServiceCache[cont]['datos']['txtComentario'];
            proyectos[posicionListaProyectosSeleccionado]['datos']['fileFotoPrincipal'] = contenidoWebServiceCache[cont]['datos']['fileFotoPrincipal'];
            proyectos[posicionListaProyectosSeleccionado]['datos']['filesFotosComplementarias'] = contenidoWebServiceCache[cont]['datos']['filesFotosComplementarias'];
          }
        }
      }
      break;
    }
  }
  contenidoWebService[0]['proyectos']          = proyectos;
  contenidoWebServiceCacheTodo[0]['proyectos'] = proyectos;
  await prefs.setString('contenidoWebService', jsonEncode(contenidoWebServiceCacheTodo));
}