abstract class Failure {
  final String message;

  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class CommonFailure extends Failure {
  const CommonFailure(String message) : super(message);
}
