abstract class Failure {
  const Failure(this.errorCode, this.description);

  final String errorCode;
  final String description;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.errorCode == errorCode &&
        other.description == description;
  }

  @override
  int get hashCode => errorCode.hashCode ^ description.hashCode;

  @override
  String toString() =>
      'Failure(errorCode: $errorCode, description: $description)';
}


class LocalFailure extends Failure {
  const LocalFailure([String errorCode = 'cache_error', String? description])
      : super(errorCode, description ?? 'Ошибка при загрузке хранилища');
}

class UnknownFailure extends Failure {
  const UnknownFailure(this.stackTrace, [String? description])
      : super('unknown_error', description ?? 'The error was not defined');

  final StackTrace stackTrace;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnknownFailure &&
        other.stackTrace == stackTrace &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode => stackTrace.hashCode ^ errorCode.hashCode;
}
