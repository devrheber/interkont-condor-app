import 'package:flutter/material.dart';

respuestaHttp(responseStatus)
{
  bool respuesta = true;

  if(responseStatus == 200){
    respuesta = true;  
  }else{
    respuesta = false;
  }

  return respuesta;

  
}
