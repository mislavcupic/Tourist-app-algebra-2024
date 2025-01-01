import 'package:flutter/material.dart';

const textColorLight = Color(0xFF171C26);
const backgroundColorLight = Color(0xFFFAFDFF);
const errorColorLight = Color(0xFFFF2D2D);
const gradientBeginColorLight = Color(0xFFD17438);
const gradientEndColorLight = Color(0xFF9D2C56);
const borderColorLight = Color(0xFFAFB1B2);
const cardTextColorLight = Color(0xFFFAFDFF);

//dark theme colors
const textColorDark = Color(0xFFFFFFFF);
const backgroundColorDark = Color(0xFF1C1C1C);
const errorColorDark = Color(0xFFFF4D4D);
const gradientBeginColorDark = Color(0xFF9C3A3A); // Svetlija crvena
const gradientEndColorDark = Color(0xFF5D2B4B);
const borderColorDark = Color(0xFF666666);
const cardTextColorDark = Color(0xFFFFFFFF);

class AppColors extends ThemeExtension<AppColors> {
  final Color? text;
  final Color? background;
  final Color? border;
  final Color? error;
  final Color? gradientBegin;
  final Color? gradientEnd;
  final Color? cardText;

  const AppColors({
    required this.text,
    required this.background,
    required this.border,
    required this.error,
    required this.gradientBegin,
    required this.gradientEnd,
    required this.cardText,
  });

  @override
  AppColors copyWith({
    final Color? text,
    final Color? background,
    final Color? border,
    final Color? error,
    final Color? gradientBegin,
    final Color? gradientEnd,
    final Color? cardText,
  }) =>
      AppColors(
        text: text ?? this.text,
        background: background ?? this.background,
        border: border ?? this.border,
        error: error ?? this.error,
        gradientBegin: gradientBegin ?? this.gradientBegin,
        gradientEnd: gradientEnd ?? this.gradientEnd,
        cardText: cardText ?? this.cardText,
      );

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      text: Color.lerp(text, other.text, t),
      background: Color.lerp(background, other.background, t),
      border: Color.lerp(border, other.border, t),
      error: Color.lerp(error, other.error, t),
      gradientBegin: Color.lerp(gradientBegin, other.gradientBegin, t),
      gradientEnd: Color.lerp(gradientEnd, other.gradientEnd, t),
      cardText: Color.lerp(cardText, other.cardText, t),
    );
  }
}
