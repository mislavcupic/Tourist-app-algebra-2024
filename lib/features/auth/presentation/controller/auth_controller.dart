import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:tourist_project_mc/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/email_verification.dart';
import '../../../../core/error/failure.dart';
import '../../../../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/app_route.dart';

class AuthController extends Notifier<AuthState> {
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final Failure failure;
  // Čitanje providera za UseCase
  @override
  AuthState build() {
    _signInUseCase = ref.watch(signInUseCaseProvider);
    _signUpUseCase = ref.watch(signUpUseCaseProvider);

    // Prati promjene stanja autentifikacije
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // Provjeri da li je korisnik verificiran
        if (user.emailVerified) {
          // Ako je verificiran, prebaci ga na SignInScreen
          state = AuthenticatedState(user);
        } else {
          // Ako nije, prebaci ga na EmailVerificationScreen
          state = EmailVerificationState(user);
        }
      } else {
        // Ako korisnik nije prijavljen, stanje je nezaštićeno
        state = UnauthenticatedState();
      }
    });

    return UnauthenticatedState();  // Defaultno stanje
  }

  // Metoda za prijavu
  void signIn(final String email, final String password) async {
    state = LoadingState();

    final result = await _signInUseCase(email, password);

    result.fold(
          (failure) => state = UnauthenticatedState(failure: failure),
          (user) => state = AuthenticatedState(user!),
    );
  }

  // Metoda za registraciju
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
          state = UnauthenticatedState(failure: failure);
        }
      },
    );
  }
  Future<void> refreshUser() async {
    try {
      final userApi = ref.read(userApiProvider); // Koristi UserApi za osvježavanje podataka o korisniku
      final refreshedUser = await userApi.getCurrentUser(); // Dohvati osvježene podatke o korisniku
      debugPrint("Refreshed User: ${refreshedUser.email}"); // Ispiši podatke o korisniku
      ref.read(authNotifier.notifier).updateUser(refreshedUser); // Ažuriraj stanje u AuthControlleru
    } catch (error) {
      debugPrint("Error refreshing user: $error"); // Ispiši greške ako ih ima
    }
  }

  void updateUser(User user) {
    debugPrint("Updating user: ${user.email}"); // Ispiši prije nego ažuriramo korisnika
    state = AuthenticatedState(user); // Ažuriraj stanje s novim podacima o korisniku
  }

}
