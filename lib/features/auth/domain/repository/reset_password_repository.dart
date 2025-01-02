import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/app_error.dart';

abstract interface class ResetPasswordRepository {
  Future<Either<AppError, Unit>> resetPassword(String email);
  Future<Either<AppError, Unit>> resendEmail(String email);
}