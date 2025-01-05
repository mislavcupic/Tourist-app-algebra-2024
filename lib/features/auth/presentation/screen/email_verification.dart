import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/common/presentation/widget/custom_primary_button.dart';

import '../../../../core/theme_notifier.dart';

class EmailVerification extends ConsumerWidget {
  const EmailVerification({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authApi = ref.watch(userApiProvider);
    final isLoading = ValueNotifier(false);
    final themeMode = ref.watch(themeNotifierProvider);
    Future<void> resendEmail() async {
      isLoading.value = true; // Start loading
      try {
        await authApi.resendVerificationEmail();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Verification email sent successfully."),
            ),
          );
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to resend email: $error"),
            ),
          );
        }
      } finally {
        isLoading.value = false; // Stop loading
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Transform.translate(
          offset: const Offset(75, 0),
          child: const Text('Verify email', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Image.asset("assets/images/mail_sent.png", width: 250),
              const SizedBox(height: 20),
              Text(
                "Please check your inbox and verify your email address.",
                style:TextStyle(

                  color: themeMode == ThemeMode.light
                      ? Colors.black
                      : Colors.white,

                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),
              Text.rich(
                TextSpan(
                  text: "Didn't receive an email? ",
                  style: TextStyle(

                    color: themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,

                  ),
                  children: [
                    TextSpan(
                      text: "Resend.",
                      style: TextStyle(

                        color: themeMode == ThemeMode.light
                            ? Colors.black
                            : Theme.of(context).primaryColorDark,

                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => resendEmail(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
