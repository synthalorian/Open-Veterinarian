import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/theme/app_theme.dart';
import '../services/database_service.dart';

class ThemeNotifier extends StateNotifier<AppThemeType> {
  ThemeNotifier() : super(_loadTheme());

  static AppThemeType _loadTheme() {
    final box = DatabaseService.getThemeBox();
    final stored = box.getAt(0);
    return stored != null ? AppThemeType.values[stored] : AppThemeType.synthwave84;
  }

  void setTheme(AppThemeType theme) {
    state = theme;
    DatabaseService.getThemeBox().putAt(0, theme.index);
  }

  ThemeData get currentTheme => AppTheme.build(state);
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppThemeType>((ref) {
  return ThemeNotifier();
});

final themeDataProvider = Provider<ThemeData>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return AppTheme.build(theme);
});

final appColorsProvider = Provider<AppColors>((ref) {
  final theme = ref.watch(themeNotifierProvider);
  return AppTheme.build(theme).extension<AppColors>()!;
});
