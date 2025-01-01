import 'package:flutter/material.dart';
import 'package:tourist_project_mc/core/style/colors.dart';

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
      cardText: cardTextColorLight,
    ),
  ],
);

final darkTheme = ThemeData(
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: backgroundColorDark,
  extensions: const [
    AppColors(
      text: textColorDark,
      background: backgroundColorDark,
      border: borderColorDark,
      error: errorColorDark,
      gradientBegin: gradientBeginColorDark,
      gradientEnd: gradientEndColorDark,
      cardText: cardTextColorDark,
    ),
  ],
);