import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/password_reset_state.dart';

import '../../../../core/error/failure.dart';


final resetPasswordControllerProvider = NotifierProvider<ResetPasswordController, PasswordResetState>(
      () => ResetPasswordController(),
);

class ResetPasswordController extends Notifier<PasswordResetState> {
  late final ResetPasswordUseCase _resetPasswordUseCase;
  late final Failure failure;
  @override
  PasswordResetState build() {
    _resetPasswordUseCase = ref.watch(resetPasswordUseCase);
    return PasswordResetInitial();
  }


  Future<void> resetPassword(String email) async {
    state = PasswordResetLoading();

    final result = await _resetPasswordUseCase.call(email);

    result.fold(
          (failure) {
        state = PasswordResetFailure(failure: failure);
      },
          (_) {
        state = PasswordResetSuccess("Password reset email sent successfully.");
      },
    );
  }
}