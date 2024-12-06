import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _buttonTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const _subtitleTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
const _titleTextStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
const _descriptionTextStyle = TextStyle(fontSize: 14);
const _cardTitleTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
const _cardSubtitleTextStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);
const _cardTextTextStyle = TextStyle(fontSize: 10);

extension CustomTextStyle on TextTheme {
  TextStyle get buttonTextStyle => _buttonTextStyle;
  TextStyle get subtitleTextStyle => _subtitleTextStyle;
  TextStyle get titleTextStyle => _titleTextStyle;
  TextStyle get descriptionTextStyle => _descriptionTextStyle;
  TextStyle get cardTitleTextStyle => _cardTitleTextStyle;
  TextStyle get cardSubtitleTextStyle => _cardSubtitleTextStyle;
  TextStyle get cardTextTextStyle => _cardTextTextStyle;
}