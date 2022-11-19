import 'dart:convert';
import 'dart:developer';

import 'package:appalimentacion/constants/constants.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/aom_datos_generales.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:appalimentacion/domain/repository/http_adapter.dart';
import 'package:dio/dio.dart' as x;

class AomProjectsImpl implements AomProjectsRepository {
  AomProjectsImpl({required HttpAdapter adapter}) : _client = adapter {
    _init();
  }

  final HttpAdapter _client;

  final UserPreferences prefs = UserPreferences();
  final String _url = urlApiAom;

  late x.Dio _dio;
  late User user;

  void _init() {
    _dio = x.Dio();
    _dio.options = x.BaseOptions(
      connectTimeout: 3500,
      baseUrl: _url,
    );

    // TODO Use interceptors

    user = User.fromJson(json.decode(prefs.userData));
  }

  Exception manageDioError(x.DioError e) {
    switch (e.type) {
      case x.DioErrorType.connectTimeout:
        throw AomProjectsSlowConnectionException();
      case x.DioErrorType.response:
        if (e.response?.statusCode == 500) {
          throw AomProjectsBackendErrorException(e.response?.data);
        }
        if (e.response?.statusCode == 403) {
          throw AomProjectsForbiddenException();
        }
        throw AomProjectsOtherEception();
      case x.DioErrorType.cancel:
        throw AomProjectsCancelException();
      case x.DioErrorType.sendTimeout:
      case x.DioErrorType.receiveTimeout:
      case x.DioErrorType.other:
        throw AomProjectsOtherEception();
      default:
        throw AomProjectsOtherEception();
    }
  }

  @override
  Future<List<Clasificacion>> getClasifications({
    x.CancelToken? cancelToken,
  }) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        ApiRoutes.getClasifications,
        options: x.Options(headers: {
          'Content-type': 'application/json',
          'Authorization': user.token
        }),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final list = clasificacionFromJson(json.encode(response.data));
        return list;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<AomDatosGenerales> getDatosGenerales(int projectCode,
      {x.CancelToken? cancelToken}) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        '${ApiRoutes.getAomDatosGenerales}/$projectCode',
        options: x.Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': user.token,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final datosGenerales =
            aomDatosGeneralesFromJson(json.encode(response.data));

        return datosGenerales;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<List<Contratista>> getContratistas(
      {x.CancelToken? cancelToken}) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        ApiRoutes.getContratistas,
        options: x.Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': user.token,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200) {
        final contratistas = contratistaFromJson(json.encode(response.data));
        return contratistas;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<List<CategoriaObra>> categoriasByObraId(int obraId,
      {x.CancelToken? cancelToken}) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        '${ApiRoutes.getCategoriasObra}/$obraId',
        options: x.Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': user.token,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.data is Map && response.data['status'] == false) {
        // Se infiere que si respuesta regres
        throw AomProjectsBackendErrorException(
          response.data,
        );
      }

      if (response.statusCode == 200) {
        final categorias = categoriaObraFromJson(json.encode(response.data));
        return categorias;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<List<GestionAom>> getGestionAom(int obraId,
      {x.CancelToken? cancelToken}) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        '${ApiRoutes.getGestionAomByObraId}/$obraId',
        options: x.Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': user.token,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.data is Map && response.data['status'] == false) {
        // Se infiere que si respuesta regres
        throw AomProjectsBackendErrorException(
          response.data,
        );
      }

      if (response.statusCode == 200) {
        final list = gestionAomFromJson(json.encode(response.data));
        return list;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<List<EstadoDeActivo>> getEstados({x.CancelToken? cancelToken}) async {
    try {
      final x.Response<dynamic> response = await _dio.get(
        ApiRoutes.getEstadosActivos,
        options: x.Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': user.token,
          },
        ),
        cancelToken: cancelToken,
      );

      if (response.data is Map && response.data['status'] == false) {
        // Se infiere que si respuesta regresa con compo status,
        // este será false, indicando que ocurrió un error.
        throw AomProjectsBackendErrorException(
          response.data,
        );
      }

      if (response.statusCode == 200) {
        final list = estadoDeActivoFromJson(json.encode(response.data));
        return list;
      }

      throw AomProjectsOtherEception();
    } on x.DioError catch (e) {
      throw manageDioError(e);
    }
  }

  @override
  Future<UploadFileResponse> uploadFile(
      {x.CancelToken? cancelToken,
      required UploadFileRequest uploadFileRequest}) async {
    _client.options(baseUrl: 'http://13.59.62.87:8090/files-ws', headers: {
      'Content-type': 'application/json',
    });
    try {
      final x.Response<dynamic> response =
          await _client.postFormData(ApiRoutes.postUploadFile, data: {
        'map': uploadFileRequest.toJson(),
        'files': {
          'image': uploadFileRequest.file.path,
        }
      });

      return uploadFileResponseFromJson(json.encode(response.data));
    } on ProjectsError catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>> sendData(
      {required AomActualizacionRequest data}) async {
    _client.options(baseUrl: urlApiAom, headers: {
      'Content-type': 'application/json',
      'Authorization': user.token,
    });

    try {
      final x.Response<dynamic> response = await _client
          .post(ApiRoutes.postActualizacionOrRequest, data: data.toJson());

      return response.data;
    } on ProjectsError catch (e) {
      rethrow;
    }
  }
}
