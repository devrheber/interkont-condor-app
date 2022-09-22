import 'package:appalimentacion/app/data/model/tipo_doc_model.dart';
import 'package:appalimentacion/app/data/provider/tipo_doc_provider.dart';

class TipoDocService {
  Future<List<TipoDoc>> getTipoDoc() => TipoDocApi().getTipoDocWithDio();
}
