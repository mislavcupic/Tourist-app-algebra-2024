import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practical_class_01/core/app_route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _redirectToNextScreen(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/camping_image.png', width: 300),
              SizedBox(height: 40),
              Lottie.asset('assets/animations/loading_dots.json', height: 100),
            ],
          ),
        ),
      ),
    );
  }

  void _redirectToNextScreen(final BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.of(context).pushNamed(AppRoute.signIn)
          : Navigator.of(context).pushNamed(AppRoute.home);
    });
  }
}
