import 'package:appalimentacion/app/data/provider/datos_alimentacion_provider.dart';

class DatosAlimentacionService {
  final DatosAlimentacionApi _api = DatosAlimentacionApi();

  Future<Map<String, dynamic>> datosAlimentacion(int codigoProyecto) =>
      _api.datosAlimentacion(codigoProyecto);
}
