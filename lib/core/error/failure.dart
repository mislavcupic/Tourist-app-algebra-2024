sealed class Failure {}

class FirebaseAuthFailure extends Failure {
  final String message;

  FirebaseAuthFailure(this.message);
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);
}