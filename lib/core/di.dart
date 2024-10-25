
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/features/auth/data/api/user_api.dart';
import 'package:practical_class_01/features/auth/data/repository/user_repository_impl.dart';
import 'package:practical_class_01/features/auth/domain/repository/user_repository.dart';
import 'package:practical_class_01/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:practical_class_01/features/auth/presentation/controller/auth_controller.dart';
import 'package:practical_class_01/features/auth/presentation/controller/state/auth_state.dart';

final userApiProvider = Provider<UserApi>((ref) => UserApi(FirebaseAuth.instance));

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(ref.watch(userApiProvider)));

final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(ref.watch(userRepositoryProvider)));

final authNotifier = NotifierProvider<AuthController, AuthState>(() => AuthController());