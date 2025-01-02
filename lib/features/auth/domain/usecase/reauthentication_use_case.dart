import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';

class ReauthenticationUseCase {
  final UserRepository _repository;

  ReauthenticationUseCase(this._repository);

  Future<Either<Failure, Unit?>> call(final String email, final String password) async {
    return _repository.reauthenticate(email, password);

  }


}


