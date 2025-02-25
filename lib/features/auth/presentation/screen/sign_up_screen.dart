import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_project_mc/core/app_route.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/email_verification.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:tourist_project_mc/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_project_mc/features/auth/presentation/widget/custom_text_field.dart';

import '../../../../core/theme_notifier.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();


  late final passwordController;
  late final confirmPasswordController;
  late final emailController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);
    final isLoading = useState(false);
    final themeMode = ref.watch(themeNotifierProvider);

    if (authState is AuthenticatedState) {
      print("SUCCESS!");
      isLoading.value = false;
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoute.home);
      }
    } else if (authState is LoadingState) {
      print("LOADING!");
      isLoading.value = true;
    } else if (authState is UnauthenticatedState) {
      isLoading.value = false;
      final failure = authState.failure;
      if (failure != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final snackBar = SnackBar(content: Text(failure.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });

      }
    } else if (authState is EmailVerificationState) {
      print("Email verification sent!");

      if (mounted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerification(),
            ),
          );
        });

      }
    }
    else if (authState is AccountDeactivatedState){
      print('Deactivated!');
      if (mounted) {


          Navigator.of(context).pushReplacementNamed(AppRoute.signIn); // Provjerite 'mounted' prije navigacije
        }



    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Transform.translate(
          offset: Offset(75, 0),
          child: Text('Register', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
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
                  Image.asset("assets/images/sign_in_image.png", width: 128),
                  const SizedBox(height: 20),
                  Text(
                    "Please create an account to continue.",
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Confirm password",
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field must not be empty.";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match.";
                      }
                      return null;
                    },
                    isPassword: true,
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 45),
                  CustomPrimaryButton(
                    child: isLoading.value
                        ? CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.white)
                        : Text("Sign up", style: context.textButton.copyWith(color: Colors.white)),
                    onPressed: () => _signUp(emailController.text, passwordController.text),
                  ),
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, // Primarna boja ostaje
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

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
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (value == null || value.isEmpty) {
      return "Field must not be empty.";
    }
    if (!regex.hasMatch(value)) {
      return "Please enter a valid email.";
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

  void _signUp(final String email, final String password) {
    if (!mounted) return;
    if (_formKey.currentState!.validate()) {
      if (password != confirmPasswordController.text) {
        final snackBar = SnackBar(content: Text("Passwords do not match."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      if (!mounted) return;
      ref.read(authNotifier.notifier).signUp(email, password);
      print("Current authState: $authNotifier");
    }
  }

}
