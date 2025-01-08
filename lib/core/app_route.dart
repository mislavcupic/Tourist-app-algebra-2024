import 'package:flutter/material.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/email_verification.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:tourist_project_mc/features/common/presentation/screen/home_screen.dart';
import 'package:tourist_project_mc/features/initialisation/presentation/screen/splash_screen.dart';
import 'package:tourist_project_mc/features/locations/presentation/location_detail/screen/location_detail_screen.dart';
import '../features/auth/presentation/screen/sign_up_screen.dart';

class AppRoute {
  AppRoute._();

  static const splash = '/';
  static const signIn = '/signIn';
  static const signUp = '/signUp';
  static const home = '/home';
  static const details = '/details';
  static const verification = '/verification';



  static Route<dynamic> generateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case details:
        return MaterialPageRoute(builder: (_) => const LocationDetailScreen());
      case verification:
        return MaterialPageRoute(builder: (_) => const EmailVerification());
      default:
        throw Exception("Route not found...");
    }
  }
}