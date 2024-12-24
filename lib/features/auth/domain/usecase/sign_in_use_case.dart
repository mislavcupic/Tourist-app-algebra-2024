import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';

class SignInUseCase {
  final UserRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, User?>> call(final String email, final String password) async {
    return _repository.signIn(email, password);
  }
}