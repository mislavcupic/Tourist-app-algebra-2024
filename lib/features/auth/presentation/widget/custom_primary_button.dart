import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/style_extensions.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;

  const CustomPrimaryButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 15, 14, 14),
          backgroundColor: context.colorGradientBegin,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {},
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [context.colorGradientBegin, context.colorGradientEnd]
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 55.0),
            alignment: Alignment.center,
            child: Text(
              text,
              style: context.textButton.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
