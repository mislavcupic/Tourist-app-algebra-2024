import 'package:flutter/material.dart';
import 'package:tourist_project_mc/core/error/failure.dart';
import 'package:tourist_project_mc/core/style/style_extensions.dart';

class ErrorStateWidget extends StatelessWidget {
  final Failure failure;

  const ErrorStateWidget(this.failure, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/error_image.png'),
        Text(failure.message, style: context.textSubtitle),
        const SizedBox(height: 10),
        Text(
          'Please try again later or check your internet connection.',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
