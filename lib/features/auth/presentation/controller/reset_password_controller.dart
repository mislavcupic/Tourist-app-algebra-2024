import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart'; // Provjeri da li imaš ispravno definisane dependency-je
import 'package:tourist_project_mc/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/password_reset_state.dart';

// Provider za kontroler resetiranja lozinke
final resetPasswordControllerProvider = NotifierProvider<ResetPasswordController, PasswordResetState>(
      () => ResetPasswordController(),
);

class ResetPasswordController extends Notifier<PasswordResetState> {
  late final ResetPasswordUseCase _resetPasswordUseCase;

  @override
  PasswordResetState build() {
    // Dobijanje ResetPasswordUseCase preko providera
    _resetPasswordUseCase = ref.watch(resetPasswordUseCase);
    return PasswordResetInitial();
  }

  // Metoda za resetiranje lozinke
  Future<void> resetPassword(String email) async {
    state = PasswordResetLoading();

    final result = await _resetPasswordUseCase.call(email);

    result.fold(
          (appError) {
        // Postavljanje greške u stanje
        state = PasswordResetFailure(appError.message);
      },
          (_) {
        // Uspješno poslan email za resetiranje
        state = PasswordResetSuccess("Password reset email sent successfully.");
      },
    );
  }
}