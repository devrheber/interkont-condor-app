import 'package:appalimentacion/app/data/provider/vista_lista_provider.dart';
import 'package:get/instance_manager.dart';

class VistaListaService {
  final VistaListaApi _api = Get.find<VistaListaApi>();

  Future<Map<String, dynamic>> vistaLista() => _api.vistaLista();
}
