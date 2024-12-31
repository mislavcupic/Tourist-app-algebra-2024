import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/app_error.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/reset_password_repository.dart';

class ResendEmailUseCase {
  final ResetPasswordRepository _repository;

  ResendEmailUseCase(this._repository);

  Future<Either<AppError, Unit>> call(String email) async {
    // Pozivamo resetPassword metodu iz repository sloja i prosljeđujemo email
    return await _repository.resendEmail(email);
  }
}