import 'package:dio/dio.dart';
import 'package:test_mobile_itae/app/core/config/network/exceptions/bad_request_exception.dart';
import 'package:test_mobile_itae/app/core/config/network/exceptions/not_found_exception.dart';

import 'exceptions/api_exception.dart';
import 'exceptions/internal_exception.dart';

class DioErrorHandler {
  static ApiException handleDioError(DioException dioError) {
    switch (dioError.response?.statusCode ?? 500) {
      case 404:
        return NotFoundException();
      case 400:
        return BadRequestException();
      default:
        return InternalException();
    }
  }
}
