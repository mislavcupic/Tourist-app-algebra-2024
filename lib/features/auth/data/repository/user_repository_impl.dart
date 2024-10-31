import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_class_01/core/error/failure.dart';
import 'package:practical_class_01/features/auth/data/api/user_api.dart';
import 'package:practical_class_01/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl(this._userApi);

  @override
  Future<Either<Failure, User?>> signIn(String email, String password) async {
    try {
      final user = await _userApi.signIn(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(FirebaseAuthFailure("Invalid email or password."));
      }
      return Left(FirebaseAuthFailure("Authentication error. Please try again."));
    } catch (e) {
      return Left(NetworkFailure("Network error. Please try again."));
    }
  }
}
