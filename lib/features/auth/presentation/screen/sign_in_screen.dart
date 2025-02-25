import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_project_mc/core/app_route.dart';
import 'package:tourist_project_mc/core/di.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';
import 'package:tourist_project_mc/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/forgot_password_screen.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/sign_up_screen.dart';
import 'package:tourist_project_mc/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_project_mc/features/auth/presentation/widget/custom_text_field.dart';

import '../../../../core/theme_notifier.dart';

class SignInScreen extends StatefulHookConsumerWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
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
            break;

          case LoadingState():
            print("LOADING!");
            isLoading.value = true;
            break;

          case UnauthenticatedState(failure: var failure):
            isLoading.value = false;
            final snackBar = SnackBar(content: Text(failure!.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;

          case EmailVerificationState():
          //ignoriraj
          case AccountDeactivatedState():

          //ignoriraj
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        text: "Forgot password?",
                        style: TextStyle(

                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,

                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                      ),
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
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(

                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,

                      ),
                      children: [
                        TextSpan(
                          text: "Sign up.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );

                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Toggle za temu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Theme",
                        style: TextStyle(

                          color: themeMode == ThemeMode.light
                              ? Colors.black
                              : Colors.white,

                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          ref.read(themeNotifierProvider.notifier).toggleTheme();
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: ref.watch(themeNotifierProvider) == ThemeMode.dark
                              ? Icon(Icons.nightlight_round, key: ValueKey('dark'), size: 28,color: context.colorText,)
                              : Icon(Icons.wb_sunny, key: ValueKey('light'), size: 28),
                        ),
                      ),

                    ],
                  ),
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
  void _testNavigatorIssue(BuildContext context) async {
    debugPrint('Start test navigator issue');
    await Future.delayed(const Duration(milliseconds: 500));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      debugPrint('Navigating to SignUp');
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoute.signUp,
            (route) => false,
      );
    });
  }
}
