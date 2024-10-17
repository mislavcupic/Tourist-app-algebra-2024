import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/auth/domain/repository/user_repository.dart';

class SignInUseCase {
  final UserRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, User?>> call(final String email, final String password) async {
    return _repository.signIn(email, password);
  }
}