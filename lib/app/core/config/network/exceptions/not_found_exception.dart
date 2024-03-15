import 'package:get/get_connect/http/src/status/http_status.dart';

import 'api_exception.dart';

class NotFoundException extends ApiException {
  NotFoundException()
      : super(httpCode: HttpStatus.notFound, message: "Recurso no encontrado");
}
