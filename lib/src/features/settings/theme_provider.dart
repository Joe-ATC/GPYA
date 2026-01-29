import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. Definir el Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

// 2. Crear el Notifier
class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const _themePrefsKey = 'theme_mode';

  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  // Cargar el tema desde SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themePrefsKey);

    if (themeIndex != null && themeIndex < ThemeMode.values.length) {
      state = ThemeMode.values[themeIndex];
    } else {
      state = ThemeMode.dark; // Predeterminado a oscuro si no hay nada guardado
    }
  }

  // Cambiar y guardar el tema
  Future<void> setTheme(ThemeMode themeMode) async {
    if (state == themeMode) return; // No hacer nada si el tema ya está seleccionado

    state = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePrefsKey, themeMode.index);
  }
}
