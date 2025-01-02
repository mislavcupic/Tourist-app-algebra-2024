import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart'; // Provjeri da li imaš ispravno definisane dependency-je
import 'package:tourist_project_mc/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/password_reset_state.dart';


final resetPasswordControllerProvider = NotifierProvider<ResetPasswordController, PasswordResetState>(
      () => ResetPasswordController(),
);

class ResetPasswordController extends Notifier<PasswordResetState> {
  late final ResetPasswordUseCase _resetPasswordUseCase;

  @override
  PasswordResetState build() {
    _resetPasswordUseCase = ref.watch(resetPasswordUseCase);
    return PasswordResetInitial();
  }


  Future<void> resetPassword(String email) async {
    state = PasswordResetLoading();

    final result = await _resetPasswordUseCase.call(email);

    result.fold(
          (appError) {
        state = PasswordResetFailure(appError.message);
      },
          (_) {
        state = PasswordResetSuccess("Password reset email sent successfully.");
      },
    );
  }
}