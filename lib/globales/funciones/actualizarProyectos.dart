
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../variables.dart';
import 'calcularValorEjecutado.dart';

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
          proyectos[conta]['ultimaFechaSincro']  = contenidoWebServiceCache[0]['proyectos'][cont]['ultimaFechaSincro'];
          proyectos[conta]['datos'] = contenidoWebServiceCache[0]['proyectos'][cont]['datos'];
          if( contenidoWebServiceCache[0]['proyectos'][cont]['porPublicar'] != null ){
            proyectos[conta]['porPublicar'] = contenidoWebServiceCache[0]['proyectos'][cont]['porPublicar'];
          }
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
    if( contenidoWebServiceCache[cont]['codigoproyecto'] == proyectos[posListaProySelec]['codigoproyecto'] ){
      if(contenidoWebServiceCache[cont]['datos'] != null){
        contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['periodoIdSeleccionado'] = contenidoWebServiceCache[cont]['datos']['periodoIdSeleccionado'];
        contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['porcentajeValorProyectadoSeleccionado'] = contenidoWebServiceCache[cont]['datos']['porcentajeValorProyectadoSeleccionado'];
        contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['porcentajeValorEjecutado'] = contenidoWebServiceCache[cont]['datos']['porcentajeValorEjecutado'];
        contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['nuevoValorEjecutado'] = contenidoWebServiceCache[cont]['datos']['nuevoValorEjecutado'];
        if(contenidoWebServiceCache[cont]['paso'] >= 1){
          for(int contActividadesCache = 0; contActividadesCache < contenidoWebServiceCache[cont]['datos']['actividades'].length; contActividadesCache++){
            for(int contActividades = 0; contActividades < proyectos[posListaProySelec]['datos']['actividades'].length; contActividades++){
              if(proyectos[posListaProySelec]['datos']['actividades'][contActividades]['actividadId'] ==  contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['actividadId']){

                contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][contActividades]['txtActividadAvance'] = contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance'];

                if(contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance'] != null){
                  
                  contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][contActividades]['cantidadEjecutada'] = double.parse('${proyectos[posListaProySelec]['datos']['actividades'][contActividades]['cantidadEjecutadaInicial']}') + double.parse('${contenidoWebServiceCache[cont]['datos']['actividades'][contActividadesCache]['txtActividadAvance']}');
                  contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][contActividades]['valorEjecutado'] = double.parse('${proyectos[posListaProySelec]['datos']['actividades'][contActividades]['cantidadEjecutada']}') * double.parse('${proyectos[posListaProySelec]['datos']['actividades'][contActividades]['valorUnitario']}');
                  contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][contActividades]['porcentajeAvance'] = double.parse('${proyectos[posListaProySelec]['datos']['actividades'][contActividades]['valorEjecutado']}') / double.parse('${proyectos[posListaProySelec]['datos']['actividades'][contActividades]['valorProgramado']}');

                  calcularValorEjecutado();
                  
                }

                break;

              }
            }              
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 2){
            proyectos[posListaProySelec]['datos']['avancesCualitativos'] = contenidoWebServiceCache[cont]['datos']['avancesCualitativos'];
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 3){
            // ACTUALIZAR LOS FACTORES DE ATRASO
            proyectos[posListaProySelec]['datos']['factoresAtrasoSeleccionados'] = contenidoWebServiceCache[cont]['datos']['factoresAtrasoSeleccionados'];
            // ACTUALIZAR PASO 3
            for(int contIndicadoresAlcanceCache = 0; contIndicadoresAlcanceCache < contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'].length; contIndicadoresAlcanceCache++ ){
              for(int contIndicadoresAlcance = 0; contIndicadoresAlcance < proyectos[posListaProySelec]['datos']['indicadoresAlcance'].length; contIndicadoresAlcance++){
                if(proyectos[posListaProySelec]['datos']['indicadoresAlcance'][contIndicadoresAlcance]['indicadorAlcanceId'] == contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'][contIndicadoresAlcanceCache]['indicadorAlcanceId']){
                  proyectos[posListaProySelec]['datos']['indicadoresAlcance'][contIndicadoresAlcance]['txtEjecucionIndicadorAlcance'] = contenidoWebServiceCache[cont]['datos']['indicadoresAlcance'][contIndicadoresAlcanceCache]['txtEjecucionIndicadorAlcance'];
                  break;
                } 
              }
            }
          }
          if(contenidoWebServiceCache[cont]['paso'] >= 4){
            var datos = contenidoWebServiceCache[cont]['datos'];
            contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['txtComentario'] = datos['txtComentario'];
            contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['fileFotoPrincipal'] = datos['fileFotoPrincipal'];
            contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['filesFotosComplementarias'] = datos['filesFotosComplementarias'];
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