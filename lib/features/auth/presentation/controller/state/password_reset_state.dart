sealed class PasswordResetState {}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetSuccess extends PasswordResetState {
  final String message;

  PasswordResetSuccess(this.message);
}

class PasswordResetFailure extends PasswordResetState {
  final String errorMessage;

  PasswordResetFailure(this.errorMessage);
}