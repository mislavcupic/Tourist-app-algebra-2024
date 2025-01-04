// reset_password_repository.dart
import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/data/api/user_api.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/reset_password_repository.dart';

import '../../presentation/controller/state/password_reset_state.dart';



class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final UserApi _userApi;

  ResetPasswordRepositoryImpl(this._userApi);

  @override
  Future<Either<Failure, Unit>> resetPassword(String email) async {
    try {
      await _userApi.sendPasswordResetEmail(email);
      return const Right(unit);
    } catch (e) {
      return Left(FirebaseAuthFailure("Failed to send password resend mail"));
    }
  }
  //reset password
  @override
  Future<Either<Failure, Unit>> resendEmail(String email) async {
    try {
      await _userApi.sendPasswordResetEmail(email);
      return right(unit);  // "unit" is used to indicate success without returning data.
    } catch (e) {
      return Left(FirebaseAuthFailure("Failed to send password resend mail"));
    }
  }
}