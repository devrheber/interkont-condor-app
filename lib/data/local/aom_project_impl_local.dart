import 'package:appalimentacion/domain/models/aom_actualizacion_request.dart';
import 'package:appalimentacion/domain/models/gestion_aom.dart';
import 'package:appalimentacion/domain/models/estado_de_activo.dart';
import 'package:appalimentacion/domain/models/contratista.dart';
import 'package:appalimentacion/domain/models/clasificacion.dart';
import 'package:appalimentacion/domain/models/categoria_obra.dart';
import 'package:appalimentacion/domain/models/aom_datos_generales.dart';
import 'package:appalimentacion/domain/models/upload_file_response.dart';
import 'package:appalimentacion/domain/models/upload_file_request.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:dio/src/cancel_token.dart';

class AomProjectImplLocal extends AomProjectsRepository {
  @override
  Future<List<CategoriaObra>> categoriasByObraId(int obraId,
      {CancelToken? cancelToken}) {
    // TODO: implement categoriasByObraId
    throw UnimplementedError();
  }

  @override
  Future<List<Clasificacion>> getClasifications({CancelToken? cancelToken}) {
    // TODO: implement getClasifications
    throw UnimplementedError();
  }

  @override
  Future<List<Contratista>> getContratistas({CancelToken? cancelToken}) {
    // TODO: implement getContratistas
    throw UnimplementedError();
  }

  @override
  Future<AomDatosGenerales> getDatosGenerales(int projectCode,
      {CancelToken? cancelToken}) {
    // TODO: implement getDatosGenerales
    throw UnimplementedError();
  }

  @override
  Future<List<EstadoDeActivo>> getEstados({CancelToken? cancelToken}) {
    // TODO: implement getEstados
    throw UnimplementedError();
  }

  @override
  Future<List<GestionAom>> getGestionAom(int obraId,
      {CancelToken? cancelToken}) {
    // TODO: implement getGestionAom
    throw UnimplementedError();

    //!FAKE DATA
    // Map<String, Map<bool, int>> activosGenerales = {
    //   'Compensación Reactiva': {true: 3},
    //   'Equipos de Control y Comunicaciones': {false: 1},
    //   'Líneas Aéreas': {false: 2},
    //   'Sistemas Solares Fotovoltaicos SSFV de\nAlta Tensión': {false: 3},
    // };
  }

  @override
  Future<UploadFileResponse> uploadFile(
      {CancelToken? cancelToken,
      required UploadFileRequest uploadFileRequest}) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> sendData(
      {required AomActualizacionRequest data}) {
    // TODO: implement sendData
    throw UnimplementedError();
  }
}
