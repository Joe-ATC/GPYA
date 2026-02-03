import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Proveedor de Riverpod para el notificador del tema
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  late SharedPreferences _prefs;

  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadTheme() async {
    await _initPrefs();
    final themeIndex = _prefs.getInt('theme');
    if (themeIndex != null) {
      state = ThemeMode.values[themeIndex];
    } else {
      state = ThemeMode.dark; // Predeterminado a oscuro si no hay nada guardado
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    if (state == themeMode) return; // No hacer nada si el tema ya está seleccionado

    state = themeMode;
    await _prefs.setInt('theme', themeMode.index);
  }
}
