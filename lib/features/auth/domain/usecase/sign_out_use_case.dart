import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';

class SignOutUseCase {
  final UserRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<Failure, Unit>> call() async {
    return _repository.signOut();
  }
}