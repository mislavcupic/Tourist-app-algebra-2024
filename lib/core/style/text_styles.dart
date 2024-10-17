import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _buttonTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const _subtitleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

extension CustomTextStyle on TextTheme {
  TextStyle get buttonTextStyle => _buttonTextStyle;
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
}