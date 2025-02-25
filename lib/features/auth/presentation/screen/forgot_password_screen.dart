import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/auth/presentation/widget/custom_text_field.dart';
import '../../../common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/reset_password_controller.dart';
import 'package:tourist_project_mc/core/theme_notifier.dart';
import '../controller/state/password_reset_state.dart';
import 'forgot_password_resend_screen.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final themeMode = ref.watch(themeNotifierProvider);
    final resetState = ref.watch(resetPasswordControllerProvider);
    final isLoading = resetState is PasswordResetLoading;

    void resetPassword() {
      final email = emailController.text;
      if (email.isNotEmpty) {

        ref.read(resetPasswordControllerProvider.notifier).resetPassword(email);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email address', style: TextStyle(

            color: themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,

          ),
          )),
        );
      }
    }


    if (resetState is PasswordResetSuccess) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordResendScreen(), // Idi na ForgotPasswordResendScreen
            ),
          );
        }
      });
    } else if (resetState is PasswordResetFailure) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(resetState.failure as String)),
          );
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Transform.translate(
          offset: const Offset(75, 0),
          child: const Text('Reset email', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Image.asset("assets/images/reset_password_email.png", width: 250),
              const SizedBox(height: 40),
              Text(
                "Please enter your email address to reset your password.",
                style:  TextStyle(

              color: themeMode == ThemeMode.light
              ? Colors.black
                : Colors.white,

              ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              CustomTextField(
                label: "Email",
                controller: emailController,
                validator: _validateEmail,
              ),

              const SizedBox(height: 20),


              CustomPrimaryButton(
                onPressed: isLoading
                    ? () {} // Prazna funkcija kada je učitavanje aktivno
                    : resetPassword,
                child: isLoading
                    ? CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                )
                    : Text(
                  "Reset password",
                  style: context.textButton.copyWith(color: Colors.white),
                ),
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
