class ApiException implements Exception {
  final String message;

  ApiException({
    required int httpCode,
    required this.message,
  });
}
