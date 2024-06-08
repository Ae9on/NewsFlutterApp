// Define a custom exception class for handling API errors
class FailureException implements Exception {
  String massage;
  FailureException({required this.massage});
}
