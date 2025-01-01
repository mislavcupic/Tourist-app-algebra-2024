import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  // Učitavanje pohranjene teme
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString('themeMode') ?? 'light';
    state = themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }
// Metoda za prebacivanje teme
  void toggleTheme() {
    state = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
  }

  // Postavljanje svijetle teme
  void setLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', 'light');
    state = ThemeMode.light;
  }

  // Postavljanje tamne teme
  void setDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', 'dark');
    state = ThemeMode.dark;
  }
}
