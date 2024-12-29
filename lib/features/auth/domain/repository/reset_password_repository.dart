
// reset_password_repository.dart
import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/app_error.dart'; // Provjerite da imate ispravan import

abstract interface class ResetPasswordRepository {
  Future<Either<AppError, Unit>> resetPassword(String email);
}