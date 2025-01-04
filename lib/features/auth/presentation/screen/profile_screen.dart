import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import '../../../../core/app_route.dart';
import '../../../common/presentation/widget/custom_primary_button.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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

        await Future.delayed(const Duration(milliseconds: 500));

        // Navigacija u post-frame callback-u
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Koristimo pushReplacementNamed da obrišemo sve prethodne rute
          Navigator.pushReplacementNamed(
            context,
            AppRoute.signIn,
          );
        });
      },
    );
  }

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

        await Future.delayed(const Duration(milliseconds: 500));

        // Navigacija u post-frame callback-u
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Obriši sve rute i preusmjeri na ekran za prijavu
          Navigator.pushReplacementNamed(
            context,
            AppRoute.signIn,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: context.textTitle, textAlign: TextAlign.left),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            CircleAvatar(
              radius: 80,
              backgroundImage: const AssetImage('assets/images/profile_placeholder.png'),
              child: user?.photoURL == null
                  ? null
                  : ClipOval(
                child: Image.asset(
                  user!.photoURL!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              user?.displayName ?? 'Name not available',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'Email not available',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            CustomPrimaryButton(
              child: Text('Deactivate Account', style: context.textButton.copyWith(color: Colors.white)),
              onPressed: () async {
                await _handleDeleteAccount(context, ref);
              },
            ),
            const SizedBox(height: 16),
            CustomPrimaryButton(
              child: Text('Sign Out', style: context.textButton.copyWith(color: Colors.white)),
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
