class AppDatabaseException implements Exception {
  final Object? message;
  final StackTrace stackTrace;

  AppDatabaseException({this.message, required this.stackTrace});
}
