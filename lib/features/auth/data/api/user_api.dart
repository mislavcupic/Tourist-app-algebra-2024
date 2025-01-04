import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  final FirebaseAuth instance;

  const UserApi(this.instance);

  Future<User?> signIn(final String email, final String password) async {
    final credentials = await instance.signInWithEmailAndPassword(email: email, password: password);
    return credentials.user;
  }


  Future<User?> signUp(String email, String password) async {
    print("API: signUp called with email: $email");

    try {
      final credentials = await instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("API: User created successfully.");

      final user = credentials.user;

      if (user != null) {
        await user.sendEmailVerification();
        print("API: Email verification sent.");
      } else {
        print("API: No user returned after sign-up.");
      }

      return user;
    } catch (e) {
      print("API: Error during sign-up - $e");
      rethrow;
    }
  }
  Future<void> resendVerificationEmail() async {
    final user = instance.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        print("API: Verification email resent.");
      } catch (e) {
        print("API: Error resending verification email - $e");
        rethrow;
      }
    } else {
      print("API: No user signed in or email already verified.");
      throw Exception("No user signed in or email already verified.");
    }
  }


  Future<void> sendPasswordResetEmail(String email) async {
    await instance.sendPasswordResetEmail(email: email);

  }

  Future<void> signOut() async {

    await instance.signOut();


  }


  Future<void> deactivate() async {
    try {
      User? user = instance.currentUser;

      if (user != null) {
        await user.delete();
        print("User account deleted successfully.");






      } else {
        print("No user is signed in.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print("The user must reauthenticate before this operation can be executed.");

      } else {
        print("Error deleting user account: ${e.message}");
      }
      throw e;
    }
  }


  Future<void> reauthenticate(String email, String password) async {
    try {
      User? user = instance.currentUser;

      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        // ne koristim, ali me dokumentacija firebase vodi da to treba isto, trebam proučiti
        await user.reauthenticateWithCredential(credential);
        print("User re-authenticated successfully.");
      } else {
        print("No user is signed in for re-authentication.");
      }
    } on FirebaseAuthException catch (e) {
      print("Error during re-authentication: ${e.message}");
      throw e;
    }
  }
}


