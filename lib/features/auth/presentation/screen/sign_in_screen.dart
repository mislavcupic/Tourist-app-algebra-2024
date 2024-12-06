import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practical_class_01/core/app_route.dart';
import 'package:practical_class_01/core/di.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';
import 'package:practical_class_01/features/auth/presentation/controller/state/auth_state.dart';
import 'package:practical_class_01/features/common/presentation/widget/custom_primary_button.dart';
import 'package:practical_class_01/features/auth/presentation/widget/custom_text_field.dart';

class SignInScreen extends StatefulHookConsumerWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);
    final isLoading = useState(false);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    useValueChanged<AuthState, void>(authState, (_, newValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (authState) {
          case AuthenticatedState():
            print("SUCCESS!");
            isLoading.value = false;
            Navigator.of(context).pushReplacementNamed(AppRoute.home);

          case LoadingState():
            print("LOADING!");
            isLoading.value = true;

          case UnauthenticatedState(failure: var failure):
            isLoading.value = false;
            final snackBar = SnackBar(content: Text(failure!.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: _formKey,
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
                  CustomTextField(
                    label: "Email",
                    controller: emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Password",
                    controller: passwordController,
                    validator: _validatePassword,
                    isPassword: true,
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
                  CustomPrimaryButton(
                    child: isLoading.value
                        ? CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white)
                        : Text("Sign in", style: context.textButton.copyWith(color: Colors.white)),
                    onPressed: () => _signIn(emailController.text, passwordController.text),
                  ),
                  const Spacer(),
                  Text(
                    "Don't have an account? Sign up.",
                    style: context.textSubtitle,
                  ), //TODO: Make this TextButton
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final regex = RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

    if (value == null || value.isEmpty) {
      return "Field must not be empty.";
    }

    if (!regex.hasMatch(value)) {
      return "Please enter valid email.";
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Field must not be empty.";
    }

    if (value.length <= 7) {
      return "Password is too short";
    }

    return null;
  }

  void _signIn(final String email, final String password) {
    if (_formKey.currentState!.validate()) {
      ref.read(authNotifier.notifier).signIn(email, password);
    }
  }
}
