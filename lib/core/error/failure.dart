sealed class Failure {
  final String message;

  Failure(this.message);
}

class FirebaseAuthFailure extends Failure {
  @override
  final String message;

  FirebaseAuthFailure(this.message) : super(message);
}

class NetworkFailure extends Failure {
  @override
  final String message;

  NetworkFailure(this.message) : super(message);
}