import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/features/auth/data/api/user_api.dart';
import 'package:practical_class_01/features/auth/data/repository/user_repository_impl.dart';
import 'package:practical_class_01/features/auth/domain/repository/user_repository.dart';
import 'package:practical_class_01/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:practical_class_01/features/auth/presentation/controller/auth_controller.dart';
import 'package:practical_class_01/features/auth/presentation/controller/state/auth_state.dart';
import 'package:practical_class_01/features/locations/data/api/location_api.dart';
import 'package:practical_class_01/features/locations/data/repository/location_repository_impl.dart';
import 'package:practical_class_01/features/locations/domain/repository/location_repository.dart';
import 'package:practical_class_01/features/locations/domain/usecase/GetAllLocationsUseCase.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/controller/location_list_controller.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/controller/state/location_list_state.dart';

//******** API ********//
final userApiProvider = Provider<UserApi>((ref) => UserApi(FirebaseAuth.instance));

final locationApiProvider = Provider<LocationApi>((ref) => LocationApi(Dio()));

//******** REPOSITORY ********//
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(ref.watch(userApiProvider)));

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepositoryImpl(ref.watch(locationApiProvider)),
);

//******** USE CASE ********//
final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(ref.watch(userRepositoryProvider)));

final getAllLocationsUseCaseProvider = Provider<GetAllLocationsUseCase>(
  (ref) => GetAllLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

//******** NOTIFIER ********//
final authNotifier = NotifierProvider<AuthController, AuthState>(() => AuthController());

final locationListNotifier = NotifierProvider<LocationListController, LocationListState>(
  () => LocationListController(),
);
