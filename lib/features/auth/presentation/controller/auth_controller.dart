import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/auth_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecase/sign_up_use_case.dart';

class AuthController extends Notifier<AuthState> {
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final Failure
  failure;


  @override
  AuthState build() {
    _signInUseCase = ref.watch(signInUseCaseProvider);
    _signUpUseCase = ref.watch(signUpUseCaseProvider);
    return UnauthenticatedState();
  }

  void signIn(final String email, final String password) async {
    state = LoadingState();

    final result = await _signInUseCase(email, password);

    result.fold(
      (failure) => state = UnauthenticatedState(failure: failure),
      (user) => state = AuthenticatedState(user!),
    );
  }

  void signUp(String email, String password) async {
    state = LoadingState();

    final result = await _signUpUseCase.call(email, password);

    result.fold(
          (failure) {
        state = UnauthenticatedState(failure: failure);
      },
          (user) {
        if (user != null) {
          state = EmailVerificationState(user);
        } else {
          state = UnauthenticatedState(
              failure: failure);
        }
      },
    );
  }
}
