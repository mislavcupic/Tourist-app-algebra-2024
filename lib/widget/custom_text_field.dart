import 'package:flutter/material.dart';
import 'package:practical_class_01/style/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).extension<AppColors>()!.ternary!,
              width: 1,
            ),
          ),
          hintText: label,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).extension<AppColors>()!.ternary!,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
