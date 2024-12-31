import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_project_mc/core/di.dart';
import '../../../common/presentation/widget/custom_primary_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
    final deleteUseCase = ref.read(deleteAccountUseCase);
    final result = await deleteUseCase();
    result.fold(
          (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete account: ${failure.message}")),
      ),
          (success) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account deleted successfully.")),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context, WidgetRef ref) async {
    final signOut = ref.read(signOutUseCase);
    final result = await signOut();
    result.fold(
          (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign out: ${failure.message}")),
      ),
          (success) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signed out successfully.")),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

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
