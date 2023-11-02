import 'package:dio/dio.dart';

import 'app_interceptors.dart';
import 'globals.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Globals.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: Globals.baseUrl,
      receiveTimeout: const Duration(minutes: 3),
      connectTimeout: const Duration(minutes: 3),
      sendTimeout: const Duration(minutes: 5),
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}
