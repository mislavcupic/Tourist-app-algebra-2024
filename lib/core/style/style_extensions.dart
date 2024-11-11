import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/colors.dart';
import 'package:practical_class_01/core/style/text_styles.dart';

extension StyleExtension on BuildContext {
  Color get colorGradientBegin => Theme.of(this).extension<AppColors>()!.gradientBegin!;
  Color get colorGradientEnd => Theme.of(this).extension<AppColors>()!.gradientEnd!;
  Color get colorText => Theme.of(this).extension<AppColors>()!.text!;
  Color get colorBackground => Theme.of(this).extension<AppColors>()!.background!;
  Color get colorBorder => Theme.of(this).extension<AppColors>()!.border!;
  Color get colorError => Theme.of(this).extension<AppColors>()!.error!;
  Color get colorCardText => Theme.of(this).extension<AppColors>()!.cardText!;

  TextStyle get textButton => Theme.of(this).textTheme.buttonTextStyle;
  TextStyle get textSubtitle => Theme.of(this).textTheme.subtitleTextStyle;
  TextStyle get textTitle => Theme.of(this).textTheme.titleTextStyle;
  TextStyle get textDescription => Theme.of(this).textTheme.descriptionTextStyle;
  TextStyle get textCardTitle => Theme.of(this).textTheme.cardTitleTextStyle.copyWith(color: colorCardText);
  TextStyle get textCardSubtitle => Theme.of(this).textTheme.cardSubtitleTextStyle.copyWith(color: colorCardText);
  TextStyle get textCardText => Theme.of(this).textTheme.cardTextTextStyle.copyWith(color: colorCardText);
}