import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/colors.dart';
import 'package:practical_class_01/core/style/text_styles.dart';

extension StyleExtension on BuildContext {
  Color get colorGradientBegin => Theme.of(this).extension<AppColors>()!.gradientBegin!;
  Color get colorGradientEnd => Theme.of(this).extension<AppColors>()!.gradientEnd!;
  Color get colorText => Theme.of(this).extension<AppColors>()!.text!;

  TextStyle get textButton => Theme.of(this).textTheme.buttonTextStyle;
  TextStyle get textSubtitle => Theme.of(this).textTheme.subtitleTextStyle;
}