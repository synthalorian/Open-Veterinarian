import 'package:flutter/material.dart';

// ─── Synthwave '84 Color Palette (from omarchy) ───
const Color sw84Background = Color(0xFF240037);
const Color sw84Surface = Color(0xFF1A002A);
const Color sw84Card = Color(0xFF2D0045);
const Color sw84Purple = Color(0xFF8F00FF);
const Color sw84Yellow = Color(0xFFF3E70F);
const Color sw84YellowBright = Color(0xFFFFFF66);
const Color sw84Pink = Color(0xFFFF00FF);
const Color sw84PinkSoft = Color(0xFFFF7EDB);
const Color sw84Cyan = Color(0xFF03EDF9);
const Color sw84Blue = Color(0xFF0080FF);
const Color sw84Red = Color(0xFFFF0040);
const Color sw84RedBright = Color(0xFFFE5442);
const Color sw84Text = Color(0xFFFFFFFF);
const Color sw84TextDim = Color(0xFFB0A0C0);

// ─── Theme Extension for app-specific colors ───
class AppColors extends ThemeExtension<AppColors> {
  final Color surface;
  final Color card;
  final Color accent;
  final Color accentSecondary;
  final Color accentTertiary;
  final Color gridColor;
  final Color textDim;
  final Color success;
  final Color warning;
  final Color danger;
  final Color glowColor;
  final Color sectionHeader;

  const AppColors({
    required this.surface,
    required this.card,
    required this.accent,
    required this.accentSecondary,
    required this.accentTertiary,
    required this.gridColor,
    required this.textDim,
    required this.success,
    required this.warning,
    required this.danger,
    required this.glowColor,
    required this.sectionHeader,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? surface,
    Color? card,
    Color? accent,
    Color? accentSecondary,
    Color? accentTertiary,
    Color? gridColor,
    Color? textDim,
    Color? success,
    Color? warning,
    Color? danger,
    Color? glowColor,
    Color? sectionHeader,
  }) {
    return AppColors(
      surface: surface ?? this.surface,
      card: card ?? this.card,
      accent: accent ?? this.accent,
      accentSecondary: accentSecondary ?? this.accentSecondary,
      accentTertiary: accentTertiary ?? this.accentTertiary,
      gridColor: gridColor ?? this.gridColor,
      textDim: textDim ?? this.textDim,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      glowColor: glowColor ?? this.glowColor,
      sectionHeader: sectionHeader ?? this.sectionHeader,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSecondary: Color.lerp(accentSecondary, other.accentSecondary, t)!,
      accentTertiary: Color.lerp(accentTertiary, other.accentTertiary, t)!,
      gridColor: Color.lerp(gridColor, other.gridColor, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      sectionHeader: Color.lerp(sectionHeader, other.sectionHeader, t)!,
    );
  }
}

// ─── Theme Index ───
enum AppThemeType {
  dark,
  light,
  synthwave,
  synthwave84;

  String get label {
    switch (this) {
      case AppThemeType.dark:
        return 'Dark';
      case AppThemeType.light:
        return 'Light';
      case AppThemeType.synthwave:
        return 'Synthwave';
      case AppThemeType.synthwave84:
        return 'Synthwave \'84';
    }
  }
}

// ─── Theme Builder ───
class AppTheme {
  static ThemeData build(AppThemeType type) {
    switch (type) {
      case AppThemeType.dark:
        return _buildDark();
      case AppThemeType.light:
        return _buildLight();
      case AppThemeType.synthwave:
        return _buildSynthwave();
      case AppThemeType.synthwave84:
        return _buildSynthwave84();
    }
  }

  static ThemeData _baseTheme({
    required Brightness brightness,
    required Color scaffoldBg,
    required Color appBarBg,
    required Color primaryColor,
    required Color textPrimary,
    required Color textSecondary,
    required Color cardColor,
    required Color dividerColor,
    required Color inputFill,
    required Color hintColor,
    required Color iconTheme,
    required Color chipSelected,
    required Color chipUnselected,
    required AppColors appColors,
  }) {
    return ThemeData(
      brightness: brightness,
      useMaterial3: false,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardColor,
      dividerColor: dividerColor,
      fontFamily: 'monospace',
      extensions: [appColors],

      appBarTheme: AppBarTheme(
        backgroundColor: appBarBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'monospace',
        ),
        iconTheme: IconThemeData(color: iconTheme),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        hintStyle: TextStyle(color: textSecondary, fontSize: 14),
        labelStyle: TextStyle(color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),

      chipTheme: ChipThemeData(
        selectedColor: chipSelected,
        disabledColor: chipUnselected,
        labelStyle: TextStyle(color: textPrimary, fontSize: 13),
        secondaryLabelStyle: TextStyle(color: textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: dividerColor),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardColor,
        contentTextStyle: TextStyle(color: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: primaryColor.withAlpha(77), width: 0.5),
        ),
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 16,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: inputFill,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: dividerColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: dividerColor)),
        ),
      ),

      dividerTheme: DividerThemeData(color: dividerColor, thickness: 0.5),
    );
  }

  // ── DARK THEME ──
  static ThemeData _buildDark() {
    return _baseTheme(
      brightness: Brightness.dark,
      scaffoldBg: const Color(0xFF020202),
      appBarBg: Colors.transparent,
      primaryColor: Colors.cyanAccent,
      textPrimary: Colors.white,
      textSecondary: Colors.grey,
      cardColor: const Color(0xFF0A0A0A),
      dividerColor: Colors.white10,
      inputFill: const Color(0xFF0A0A0A),
      hintColor: Colors.grey,
      iconTheme: Colors.cyanAccent,
      chipSelected: Colors.cyanAccent,
      chipUnselected: Colors.white10,
      appColors: const AppColors(
        surface: Color(0xFF020202),
        card: Color(0xFF0A0A0A),
        accent: Colors.cyanAccent,
        accentSecondary: Colors.cyan,
        accentTertiary: Colors.tealAccent,
        gridColor: Colors.cyan,
        textDim: Colors.grey,
        success: Colors.greenAccent,
        warning: Colors.orangeAccent,
        danger: Colors.redAccent,
        glowColor: Colors.cyanAccent,
        sectionHeader: Colors.white70,
      ),
    );
  }

  // ── LIGHT THEME ──
  static ThemeData _buildLight() {
    return _baseTheme(
      brightness: Brightness.light,
      scaffoldBg: const Color(0xFFF5F5F5),
      appBarBg: Colors.white,
      primaryColor: const Color(0xFF0080FF),
      textPrimary: const Color(0xFF1A1A2E),
      textSecondary: const Color(0xFF6B7280),
      cardColor: Colors.white,
      dividerColor: const Color(0xFFE5E7EB),
      inputFill: const Color(0xFFF9FAFB),
      hintColor: const Color(0xFF9CA3AF),
      iconTheme: const Color(0xFF0080FF),
      chipSelected: const Color(0xFF0080FF),
      chipUnselected: const Color(0xFFE5E7EB),
      appColors: const AppColors(
        surface: Color(0xFFF5F5F5),
        card: Colors.white,
        accent: Color(0xFF0080FF),
        accentSecondary: Color(0xFF0066CC),
        accentTertiary: Color(0xFF00A3FF),
        gridColor: Color(0xFF0080FF),
        textDim: Color(0xFF6B7280),
        success: Color(0xFF059669),
        warning: Color(0xFFD97706),
        danger: Color(0xFFDC2626),
        glowColor: Color(0xFF0080FF),
        sectionHeader: Color(0xFF4B5563),
      ),
    );
  }

  // ── SYNTHWAVE THEME ──
  static ThemeData _buildSynthwave() {
    return _baseTheme(
      brightness: Brightness.dark,
      scaffoldBg: const Color(0xFF0D0A1A),
      appBarBg: Colors.transparent,
      primaryColor: const Color(0xFF7C3AED),
      textPrimary: Colors.white,
      textSecondary: const Color(0xFF9CA3AF),
      cardColor: const Color(0xFF1A1040),
      dividerColor: const Color(0xFF7C3AED).withAlpha(51),
      inputFill: const Color(0xFF1A1040),
      hintColor: const Color(0xFF9CA3AF),
      iconTheme: const Color(0xFF7C3AED),
      chipSelected: const Color(0xFF7C3AED),
      chipUnselected: const Color(0xFF1A1040),
      appColors: const AppColors(
        surface: Color(0xFF0D0A1A),
        card: Color(0xFF1A1040),
        accent: Color(0xFF7C3AED),
        accentSecondary: Color(0xFFEC4899),
        accentTertiary: Color(0xFFFBBF24),
        gridColor: Color(0xFF7C3AED),
        textDim: Color(0xFF9CA3AF),
        success: Color(0xFF34D399),
        warning: Color(0xFFFBBF24),
        danger: Color(0xFFEF4444),
        glowColor: Color(0xFF7C3AED),
        sectionHeader: Color(0xFFA78BFA),
      ),
    );
  }

  // ── SYNTHWAVE '84 THEME (matches omarchy) ──
  static ThemeData _buildSynthwave84() {
    return _baseTheme(
      brightness: Brightness.dark,
      scaffoldBg: sw84Background,
      appBarBg: Colors.transparent,
      primaryColor: sw84Purple,
      textPrimary: sw84Text,
      textSecondary: sw84TextDim,
      cardColor: sw84Card,
      dividerColor: sw84Purple.withAlpha(51),
      inputFill: sw84Surface,
      hintColor: sw84TextDim,
      iconTheme: sw84Pink,
      chipSelected: sw84Purple,
      chipUnselected: sw84Surface,
      appColors: const AppColors(
        surface: sw84Background,
        card: sw84Card,
        accent: sw84Purple,
        accentSecondary: sw84Yellow,
        accentTertiary: sw84Pink,
        gridColor: sw84Purple,
        textDim: sw84TextDim,
        success: Color(0xFF34D399),
        warning: sw84Yellow,
        danger: sw84Red,
        glowColor: sw84Pink,
        sectionHeader: sw84PinkSoft,
      ),
    );
  }
}
