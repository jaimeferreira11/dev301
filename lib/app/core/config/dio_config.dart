import 'package:dio/dio.dart';
import 'package:test_mobile_itae/app/core/config/app_constants.dart';

import 'pretty_dio_logger.dart';

class DioService {
  static DioService _singletonHttp = DioService._internal();
  late Dio _http;

  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: _maxLineWidth);

  factory DioService() {
    _singletonHttp = DioService._internal();
    return _singletonHttp;
  }

  DioService._internal() {
    init();
  }

  init() {
    _http = Dio();

    _http.options.baseUrl = AppConstants.apiURL;

    _http.options.connectTimeout = const Duration(seconds: 5);
    _http.options.receiveTimeout = const Duration(seconds: 3);
    _http.interceptors.add(_prettyDioLogger);
  }

  Dio get client => _http;

  dispose() {
    _http.close();
  }
}
