import 'package:flutter/material.dart';
import 'package:practical_class_01/core/style/colors.dart';

final lightTheme = ThemeData(
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: backgroundColorLight,
  extensions: const [
    AppColors(
      text: textColorLight,
      background: backgroundColorLight,
      border: borderColorLight,
      error: errorColorLight,
      gradientBegin: gradientBeginColorLight,
      gradientEnd: gradientEndColorLight,
    ),
  ],
);