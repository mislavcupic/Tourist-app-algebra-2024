// reset_password_repository.dart
import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/data/api/user_api.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/reset_password_repository.dart';
import 'package:tourist_project_mc/core/error/app_error.dart';


class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final UserApi _userApi;

  ResetPasswordRepositoryImpl(this._userApi);

  @override
  Future<Either<AppError, Unit>> resetPassword(String email) async {
    try {
      await _userApi.sendPasswordResetEmail(email);
      return const Right(unit);
    } catch (e) {
      return left(AppError(message: e.toString())); // Zamjena Failure s AppError
    }
  }
  //reset password
  @override
  Future<Either<AppError, Unit>> resendEmail(String email) async {
    try {
      await _userApi.sendPasswordResetEmail(email);
      return right(unit);  // "unit" is used to indicate success without returning data.
    } on AppError catch (e) {
      return left(AppError(message: e.toString()));
    }
  }
}