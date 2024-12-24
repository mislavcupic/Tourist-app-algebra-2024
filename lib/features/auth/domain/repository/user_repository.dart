import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/error/failure.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User?>> signIn(String email, String password);
}