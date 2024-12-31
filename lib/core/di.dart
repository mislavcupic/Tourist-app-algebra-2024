import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/features/auth/data/api/user_api.dart';
import 'package:tourist_project_mc/features/auth/data/repository/user_repository_impl.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/user_repository.dart';
import 'package:tourist_project_mc/features/auth/domain/repository/reset_password_repository.dart';
import 'package:tourist_project_mc/features/auth/data/repository/reset_password_repository_impl.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/delete_account_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/reauthentication_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/resend_email_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_out_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/auth_controller.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_project_mc/features/locations/data/api/location_api.dart';
import 'package:tourist_project_mc/features/locations/data/database/database_manager.dart';
import 'package:tourist_project_mc/features/locations/data/database/hive_manager.dart';
import 'package:tourist_project_mc/features/locations/data/repository/location_repository_impl.dart';
import 'package:tourist_project_mc/features/locations/domain/repository/location_repository.dart';
import 'package:tourist_project_mc/features/locations/domain/usecase/get_all_locations_use_case.dart';
import 'package:tourist_project_mc/features/locations/domain/usecase/get_favorite_locations_use_case.dart';
import 'package:tourist_project_mc/features/locations/domain/usecase/remove_location_as_favorite_use_case.dart';
import 'package:tourist_project_mc/features/locations/domain/usecase/set_location_as_favorite_use_case.dart';
import 'package:tourist_project_mc/features/locations/presentation/favorite_list/controller/favorite_list_controller.dart';
import 'package:tourist_project_mc/features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';
import 'package:tourist_project_mc/features/locations/presentation/location_list/controller/location_list_controller.dart';
import 'package:tourist_project_mc/features/locations/presentation/location_list/controller/state/location_list_state.dart';

//******** API ********//
final userApiProvider = Provider<UserApi>((ref) => UserApi(FirebaseAuth.instance));

final locationApiProvider = Provider<LocationApi>((ref) => LocationApi(Dio()));

//******** DATABASE ********//
final databaseMangerProvider = Provider<DatabaseManager>((ref) => HiveDatabaseManager());

//******** REPOSITORY ********//
final resetPasswordRepositoryProvider = Provider<ResetPasswordRepository>((ref) => ResetPasswordRepositoryImpl(ref.watch(userApiProvider)));
final resendEmailRepositoryProvider = Provider<ResetPasswordRepository>((ref) => ResetPasswordRepositoryImpl(ref.watch(userApiProvider)));
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(ref.watch(userApiProvider)));

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepositoryImpl(
    ref.watch(locationApiProvider),
    ref.watch(databaseMangerProvider),
  ),
);

//******** USE CASE ********//
final signOutUseCase = Provider<SignOutUseCase>((ref) => SignOutUseCase(ref.watch(userRepositoryProvider)));
final reauthenticationUseCase = Provider<ReauthenticationUseCase>((ref) => ReauthenticationUseCase(ref.watch(userRepositoryProvider)));
final deleteAccountUseCase = Provider<DeleteAccountUseCase>((ref) => DeleteAccountUseCase(ref.watch(userRepositoryProvider)));
final resendEmailUseCase = Provider<ResendEmailUseCase>((ref) => ResendEmailUseCase(ref.watch(resendEmailRepositoryProvider)));
final resetPasswordUseCase = Provider<ResetPasswordUseCase>((ref) => ResetPasswordUseCase(ref.watch(resetPasswordRepositoryProvider)));
final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(ref.watch(userRepositoryProvider)));
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) => SignUpUseCase(ref.watch(userRepositoryProvider)));
final getAllLocationsUseCaseProvider = Provider<GetAllLocationsUseCase>(
  (ref) => GetAllLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

final getAllFavoriteLocationsUseCaseProvider = Provider<GetAllFavoriteLocationsUseCase>(
  (ref) => GetAllFavoriteLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

final setAsFavoriteUseCaseProvider = Provider<SetLocationAsFavoriteUseCase>(
  (ref) => SetLocationAsFavoriteUseCase(ref.watch(locationRepositoryProvider)),
);

final removeAsFavoriteUseCaseProvider = Provider<RemoveAsFavoriteUseCase>(
  (ref) => RemoveAsFavoriteUseCase(ref.watch(locationRepositoryProvider)),
);

//******** NOTIFIER ********//
final authNotifier = NotifierProvider<AuthController, AuthState>(() => AuthController());

final locationListNotifier = NotifierProvider<LocationListController, LocationListState>(
  () => LocationListController(),
);

final favoriteListNotifier = NotifierProvider<FavoriteListController, FavoriteListState>(
  () => FavoriteListController(),
);
