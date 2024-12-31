import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/di.dart';
import '../../../../core/app_route.dart';
import '../../../common/presentation/widget/custom_primary_button.dart';
import '../controller/state/auth_state.dart';

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

        await Future.delayed(const Duration(milliseconds: 500)); // Kratko kašnjenje za UX

        // Navigacija u post-frame callback-u
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.signIn,
                (route) => false,
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

        await Future.delayed(const Duration(milliseconds: 500)); // Kratko kašnjenje za UX

        // Navigacija u post-frame callback-u
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.signUp,
                (route) => false,
          );
        });
      },
    );
  }

  void _checkUserStatus(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = ModalRoute.of(context)?.settings.name;

      if (authState is AccountDeactivatedState && currentRoute != AppRoute.signUp) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signUp,
              (route) => false,
        );
      } else if (authState is UnauthenticatedState && currentRoute != AppRoute.signIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.signIn,
              (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    // Provera statusa korisnika
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus(context, ref);
    });

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
            Text(
              user?.displayName ?? 'Name not available',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user?.email ?? 'Email not available',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
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