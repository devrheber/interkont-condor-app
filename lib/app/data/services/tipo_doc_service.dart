import 'package:appalimentacion/app/data/model/tipo_doc_model.dart';
import 'package:appalimentacion/app/data/provider/tipo_doc_provider.dart';
import 'package:get/instance_manager.dart';

class TipoDocService {
  final TipoDocApi _api = Get.find<TipoDocApi>();
  Future<List<TipoDoc>> getTipoDoc() => _api.getTipoDocWithDio();
}
