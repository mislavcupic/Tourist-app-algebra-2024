import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/error/failure.dart';

abstract interface class UserRepository {
  //signIn
  Future<Either<Failure, User?>> signIn(String email, String password);

  //signUp
  Future<Either<Failure, User?>> signUp(String email,String password);

 //signout
  Future<Either<Failure,Unit>> signOut();

  //delete account
  Future<Either<Failure,Unit>> deactivate();

  //reauthenticate - ne koristim
  Future<Either<Failure,Unit>> reauthenticate(String email,String password);
}