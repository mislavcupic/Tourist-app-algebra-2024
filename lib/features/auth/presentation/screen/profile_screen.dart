import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/sign_up_screen.dart';
import '../../../../core/app_route.dart';
import '../../../common/presentation/widget/custom_primary_button.dart';
import '../controller/state/auth_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Funkcija za brisanje naloga
  Future<void> _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
    final deleteUseCase = ref.read(deleteAccountUseCase);
    final result = await deleteUseCase();

    result.fold(
          (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete account: ${failure.message}")),
        );
      },
          (success) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account deleted successfully.")),
        );

        // Dodavanje odlaganja pre navigacije
        await Future.delayed(Duration(milliseconds: 500));

        // Provera da li je korisnik uspešno deaktiviran i navigacija ka signUp
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signUp,
              (route) => false, // Uklanja sve prethodne ekrane
        );
      },
    );
  }

  // Funkcija za odjavu
  Future<void> _handleSignOut(BuildContext context, WidgetRef ref) async {
    final signOut = ref.read(signOutUseCase);
    final result = await signOut();

    result.fold(
          (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to sign out: ${failure.message}")),
        );
      },
          (success) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signed out successfully.")),
        );

        // Dodavanje odlaganja pre navigacije
        await Future.delayed(Duration(milliseconds: 500));

        // Provera da li je korisnik uspešno odjavljen i navigacija ka signIn
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signIn,
              (route) => false, // Uklanja sve prethodne ekrane
        );
      },
    );
  }

  // Funkcija koja proverava korisnički status pre nego što se korisnik preusmeri
  void _checkUserStatus(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = ModalRoute.of(context)?.settings.name;

      // Ako je korisnik nedovoljno autentifikovan (deaktiviran), preusmeri ga na signUp ekran
      if (authState is UnauthenticatedState && currentRoute != AppRoute.signIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signIn,
              (route) => false, // Uklanja sve prethodne ekrane
        );
      } else if (authState is AccountDeactivatedState && currentRoute != AppRoute.signUp) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signUp,
              (route) => false, // Uklanja sve prethodne ekrane
        );
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    // Proveravamo korisnički status pri učitavanju stranice
    _checkUserStatus(context, ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage('assets/images/profile_placeholder.png'),
              child: user?.photoURL == null
                  ? null
                  : ClipOval(
                child: Image.network(
                  user!.photoURL!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Display Name
            Text(
              user?.displayName ?? 'Name not available',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Email Address
            Text(
              user?.email ?? 'Email not available',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Buttons
            CustomPrimaryButton(
              child: const Text('Deactivate Account'),
              onPressed: () async {
                await _handleDeleteAccount(context, ref);
              },
            ),
            const SizedBox(height: 16),
            CustomPrimaryButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                await _handleSignOut(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }
}

