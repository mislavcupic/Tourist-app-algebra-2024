import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';

class DeleteAccountUseCase {
  final UserRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, Unit?>> call() async {
    return _repository.deactivate();

  }


}