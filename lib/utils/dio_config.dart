import 'package:dio/dio.dart';

// ignore: constant_identifier_names
const JSON_HEADER = "Content-Type:application/json";

// ignore: constant_identifier_names
const JSON_HEADER_MULTIPART = "Content-Type:multipart/form-data";

class DioConfig {
  static final DioConfig _instance = DioConfig.internal();

  String baseurl =
      "https://my-json-server.typicode.com/arkaisho/jsonPlaceHolder";

  factory DioConfig() => _instance;

  DioConfig.internal();

  final _dio = Dio();
  final String _baseUrl = '';

  get dio {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.interceptors.add(CustomInterceptors());
    return _dio;
  }
}

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["Accept"] = "application/json";
    options.responseType = ResponseType.json;
    return super.onRequest(options, handler);
  }
}
