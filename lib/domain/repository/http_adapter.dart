import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class HttpAdapter {
  HttpAdapter({
    required this.url,
  });

  final String url;

  late Dio _dio;
  init() {
    _dio = Dio(BaseOptions(
      baseUrl: url,
      connectTimeout: 3500,
      headers: <String, dynamic>{
        'Content-type': 'application/json',
      },
    ));
  }

  Future<Response<T>> get<T>(String path) async {
    try {
      return _dio.get(path);
    } on DioError catch (e) {
      throw manageDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
  }) async {
    try {
      return _dio.post(path, data: data);
    } on DioError catch (e) {
      throw manageDioError(e);
    }
  }

  Future<Response<T>> postFormData<T>(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final formData = await _getData(map: data['map'], images: data['files']);

      return _dio.post(path, data: formData);
      // throw UnimplementedError();
    } on DioError catch (e) {
      throw manageDioError(e);
    }
  }

  Future<FormData> _getData({
    required Map<String, dynamic> map,
    Map<String, dynamic>? images,
  }) async {
    final FormData formData = FormData.fromMap(map);

    if (images != null) {
      for (final entry in images.entries) {
        formData.files.add(
          MapEntry<String, MultipartFile>(
            'file',
            await MultipartFile.fromFile(
              entry.value,
              filename: entry.value.split('/').last,
              contentType: MediaType(entry.key, entry.value.split('.').last),
            ),
          ),
        );
      }
    }

    return formData;
  }

  void options({String? baseUrl, Map<String, dynamic>? headers}) {
    _dio.options = BaseOptions(baseUrl: baseUrl ?? this.url, headers: headers);
  }

  ProjectsError manageDioError(DioError e) {
    _Response customResponse = _Response(
      statusCode: e.response?.statusCode,
      statusMessage: e.response?.statusMessage,
    );

    final String? message = e.response?.data?['message'];
    switch (e.type) {
      case DioErrorType.connectTimeout:
        throw ProjectsError(
          type: ProjectsErrorType.slowConnection,
          response: customResponse.copyWith(
            data: {
              'message': message ?? 'Verifique su conección a internet',
            },
          ),
        );
      case DioErrorType.response:
        if (e.response?.statusCode == 500) {
          throw ProjectsError(
            type: ProjectsErrorType.backend,
            response: customResponse.copyWith(
              data: {
                'message': message ?? 'Error interno en el servidor',
              },
            ),
          );
        }
        if (e.response?.statusCode == 403) {
          throw ProjectsError(
            type: ProjectsErrorType.backend,
            response: customResponse.copyWith(
              data: {
                'message': message ?? 'Su sesión ha expirado',
              },
            ),
          );
        }
        throw ProjectsError(
          type: ProjectsErrorType.other,
          response: customResponse.copyWith(
            data: {
              'message': message ?? 'Error inesperado',
            },
          ),
        );
      case DioErrorType.cancel:
        throw ProjectsError(
          type: ProjectsErrorType.cancel,
          response: customResponse.copyWith(
            data: {
              'message': message ?? 'Petición cancelada',
            },
          ),
        );
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.other:
        throw throw ProjectsError(
          type: ProjectsErrorType.other,
          response: customResponse.copyWith(
            data: {
              'message': message ?? 'Error inesperado',
            },
          ),
        );
      default:
        throw ProjectsError(
          type: ProjectsErrorType.other,
          response: customResponse.copyWith(
            data: {
              'message': message ?? 'Error inesperado',
            },
          ),
        );
    }
  }
}

enum ProjectsErrorType {
  backend,
  slowConnection,
  forbidden,
  cancel,
  other,
}

class ProjectsError implements Exception {
  ProjectsError({this.response, required this.type});

  final _Response? response;
  ProjectsErrorType type;
}

class _Response<T> {
  _Response({this.statusCode, this.statusMessage, this.data});

  final int? statusCode;
  final String? statusMessage;
  final T? data;

  _Response copyWith({
    int? statusCode,
    String? statusMessage,
    T? data,
  }) {
    return _Response(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
      data: data ?? this.data,
    );
  }
}
