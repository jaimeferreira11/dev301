import 'package:get/get_connect/http/src/status/http_status.dart';

import 'api_exception.dart';

class InternalException extends ApiException {
  InternalException()
      : super(
            httpCode: HttpStatus.internalServerError,
            message: "Error inesperado");
}
