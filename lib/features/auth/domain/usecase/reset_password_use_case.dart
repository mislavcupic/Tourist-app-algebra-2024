import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/app_error.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Either<AppError, Unit>> call(String email) async {
    return await _repository.resetPassword(email);
  }
}