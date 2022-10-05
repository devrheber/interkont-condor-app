import 'package:appalimentacion/app/data/model/datos_alimentacion.dart';
import 'package:appalimentacion/app/data/model/tipo_doc_model.dart';
import 'package:appalimentacion/app/data/provider/datos_alimentacion_api.dart';
import 'package:appalimentacion/app/data/provider/tipo_doc_provider.dart';
import 'package:flutter/foundation.dart';

class TipoDocService {
  Future<List<TipoDoc>> getTipoDoc() => TipoDocApi().getTipoDocWithDio();

  Future<DatosAlimentacion> getDatosAlimentacion({
    @required String codigoProyecto,
    bool actualizarCache = false,
  }) =>
      DatosAlimentacionApi().obtenerDatosProyecto(
        codigoProyecto: codigoProyecto,
        actualizarCache: actualizarCache,
      );
}
