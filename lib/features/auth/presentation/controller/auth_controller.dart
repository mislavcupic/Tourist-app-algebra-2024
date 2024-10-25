import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:practical_class_01/features/auth/presentation/controller/state/auth_state.dart';

class AuthController extends Notifier<AuthState> {
  late final SignInUseCase _signInUseCase;

  @override
  AuthState build() {
    _signInUseCase = ref.watch(signInUseCaseProvider);
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
}
