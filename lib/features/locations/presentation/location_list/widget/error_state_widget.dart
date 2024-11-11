import 'package:flutter/material.dart';
import 'package:practical_class_01/core/error/failure.dart';

class ErrorStateWidget extends StatelessWidget {
  final Failure failure;

  const ErrorStateWidget(this.failure, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(failure.message);
  }
}
