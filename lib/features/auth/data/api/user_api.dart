import 'package:firebase_auth/firebase_auth.dart';

class UserApi {
  final FirebaseAuth instance;

  const UserApi(this.instance);

  Future<User?> signIn(final String email, final String password) async {
    final credentials = await instance.signInWithEmailAndPassword(email: email, password: password);
    return credentials.user;
  }

  //sign_up - firebase
  /* kod koji smo koristili dosad
  Future<User?> signUp(String email, String password) async {
    final credentials = await instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credentials.user;

    if (user != null) {
      await user.sendEmailVerification();
      print('User is successfully creatan');// Slanje verifikacijskog emaila
    }

    return user;
  }
*/
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
      rethrow; // Ponovno pokreće grešku, tako da možete obraditi u gornjem sloju
    }
  }


}