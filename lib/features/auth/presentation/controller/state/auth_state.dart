import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/error/failure.dart';

sealed class AuthState {}

class AuthenticatedState extends AuthState{
  final User user;

  AuthenticatedState(this.user);
}

class LoadingState extends AuthState{}

class UnauthenticatedState extends AuthState {
  final Failure? failure;

  UnauthenticatedState({this.failure = null});
}
class EmailVerificationState extends AuthState {
  final User user;

  EmailVerificationState(this.user);
}

