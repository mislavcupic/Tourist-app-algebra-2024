import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_class_01/core/error/failure.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User?>> signIn(String email, String password);
}