import 'dart:convert';

import 'package:appalimentacion/constants/constants.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:dio/dio.dart' as x;

class AomProjectsImpl implements AomProjectsRepository {
  final UserPreferences prefs = UserPreferences();
  final String _url = urlApiAom;

  @override
  Future<List<Clasificacion>> getClasifications({
    x.CancelToken? cancelToken,
  }) async {
    x.Dio _dio = x.Dio();
    _dio.options = x.BaseOptions(
      connectTimeout: 3500,
      baseUrl: _url,
    );

    final user = User.fromJson(json.decode(prefs.userData));

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
      switch (e.type) {
        case x.DioErrorType.connectTimeout:
          throw AomProjectsSlowConnectionException();
        case x.DioErrorType.response:
          if (e.response?.statusCode == 500) {
            throw AomProjectsBackendErrorException();
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
  }
}
