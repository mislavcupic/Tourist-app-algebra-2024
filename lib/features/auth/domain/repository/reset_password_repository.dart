import 'package:dartz/dartz.dart';
import 'package:tourist_project_mc/core/error/failure.dart';


abstract interface class ResetPasswordRepository {
  Future<Either<Failure, Unit>> resetPassword(String email);
  Future<Either<Failure, Unit>> resendEmail(String email);
}