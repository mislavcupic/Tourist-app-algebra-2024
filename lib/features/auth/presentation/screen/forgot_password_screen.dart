import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/auth/presentation/widget/custom_text_field.dart';

import '../../../common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/reset_password_controller.dart';

import '../controller/state/password_reset_state.dart'; // Import za tvoj kontroler

class ForgotPasswordScreen extends ConsumerWidget { // Koristimo ConsumerWidget da bi imali pristup `ref`
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();

    // Pristupamo stanju iz kontrolera za provjeru da li je učitavanje aktivno
    final isLoading = ref.watch(resetPasswordControllerProvider.select((state) => state is PasswordResetLoading));

    // Metoda za pozivanje resetiranja lozinke
    void resetPassword() {
      final email = emailController.text;
      if (email.isNotEmpty) {
        // Pozivanje metode za resetiranje lozinke
        ref.read(resetPasswordControllerProvider.notifier).resetPassword(email);
      } else {
        // Možete dodati poruku o grešci ako email nije unešen
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid email address')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Slika (npr. ikona resetiranja lozinke)
              Image.asset("assets/images/reset_password_email.png", width: 250),

              const SizedBox(height: 20),

              // Tekst
              Text(
                "Please enter your email address to reset your password.",
                style: context.textSubtitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Unos email adrese
              CustomTextField(
                label: "Email",
                controller: emailController,
                validator: _validateEmail,
              ),

              const SizedBox(height: 20),

              // Dugme za resetiranje lozinke
              CustomPrimaryButton(
                onPressed: isLoading ? () {} : resetPassword, // Onemogućiti dugme kada je učitavanje aktivno
                child: isLoading
                    ? CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white)
                    : Text("Reset password", style: context.textButton.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty) {
      return "Field must not be empty.";
    }
    if (!regex.hasMatch(value)) {
      return "Please enter a valid email.";
    }
    return null;
  }
}
