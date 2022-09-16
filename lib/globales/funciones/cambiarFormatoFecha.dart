cambiarFormatoFecha(fecha)
{
  var listaFecha = fecha.split(" ");
 

  switch (listaFecha[0]) {
    case 'Jan': listaFecha[0] = 'Enero'; break;
    case 'Feb': listaFecha[0] = 'Febrero'; break;
    case 'Mar': listaFecha[0] = 'Marzo'; break;
    case 'Apr': listaFecha[0] = 'Abril'; break;
    case 'May': listaFecha[0] = 'Mayo'; break;
    case 'Jun': listaFecha[0] = 'Junio'; break;
    case 'Jul': listaFecha[0] = 'Julio'; break;
    case 'Aug': listaFecha[0] = 'Agosto'; break;
    case 'Sep': listaFecha[0] = 'Septiem'; break;
    case 'Oct': listaFecha[0] = 'Octubre'; break;
    case 'Nov': listaFecha[0] = 'Noviem'; break;
    case 'Dec': listaFecha[0] = 'Diciem'; break;
      break;
    default:
  }

  return listaFecha[0]+" "+listaFecha[1]+" "+listaFecha[2]+" "+listaFecha[3];
}