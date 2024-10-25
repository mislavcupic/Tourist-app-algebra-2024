import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/auth/presentation/controller/state/auth_state.dart';
import 'package:practical_class_01/features/auth/presentation/widget/custom_primary_button.dart';
import 'package:practical_class_01/features/auth/presentation/widget/custom_text_field.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifier);

    useValueChanged<AuthState, void>(authState, (_, newValue) {
      
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/sign_in_image.png", width: 250),
                const SizedBox(height: 20),
                Text(
                  "Please sign in to your account.",
                  style: context.textSubtitle,
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  label: "Email",
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  label: "Password",
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 45),
                const CustomPrimaryButton(text: "Sign in"),
                const Spacer(),
                Text(
                  "Don't have an account? Sign up.",
                  style: context.textSubtitle,
                ), //TODO: Make this TextButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
