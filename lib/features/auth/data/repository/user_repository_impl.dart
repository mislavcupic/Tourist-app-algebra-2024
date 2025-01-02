import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/features/auth/data/api/user_api.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl(this._userApi);

  @override
  Future<Either<Failure, User?>> signIn(String email, String password) async {
    try {
      final user = await _userApi.signIn(email, password);
      if (user != null && !user.emailVerified) {
        return Left(
            FirebaseAuthFailure("Please verify your email before logging in."));
      }

      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(FirebaseAuthFailure("Invalid email or password."));
      }
      return Left(
          FirebaseAuthFailure("Authentication error. Please try again."));
    } catch (e) {
      return Left(NetworkFailure("Network error. Please try again."));
    }
  }

  @override
  Future<Either<Failure, User?>> signUp(String email, String password) async {
    try {
      final user = await _userApi.signUp(email, password);
      print("Repository: User received: ${user?.email}");
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(FirebaseAuthFailure(
            "The email is already in use. Please use a different email."));
      } else if (e.code == 'weak-password') {
        return Left(FirebaseAuthFailure(
            "The password is too weak. Please choose a stronger password."));
      }
      return Left(FirebaseAuthFailure(
          "An error occurred during registration. Please try again."));
    } catch (e) {
      // Obrada općenitih grešaka (npr. mrežnih problema)
      return Left(NetworkFailure("Network error. Please try again."));
    }
  }


  //signout
  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _userApi.signOut();
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure(e.message ?? "Error occurred."));
    } catch (e) {
      return left(NetworkFailure("Network error. Please try again."));
    }
  }

  //deactivate - delete user
  @override
  Future<Either<Failure, Unit>> deactivate() async {
    try {
      await _userApi.deactivate();
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure(e.message ?? "Error occurred."));
    } catch (e) {
      return left(NetworkFailure("Network error. Please try again."));
    }
  }
@override
  Future<Either<Failure, Unit>> reauthenticate(String email,
      String password) async {
    try {
      await _userApi.reauthenticate(email, password);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure(e.message ?? "Error occurred."));
    } catch (e) {
      return left(NetworkFailure("Network error. Please try again."));
    }
  }
}

