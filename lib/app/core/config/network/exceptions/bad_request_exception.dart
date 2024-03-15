import 'package:get/get_connect/http/src/status/http_status.dart';

import 'api_exception.dart';

class BadRequestException extends ApiException {
  BadRequestException()
      : super(httpCode: HttpStatus.badRequest, message: "Datos no válidos");
}
