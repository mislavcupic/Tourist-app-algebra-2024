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
      return Left(AppError(message: e.toString())); // Zamjena Failure s AppError
    }
  }
}