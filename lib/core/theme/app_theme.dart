import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Material 3 light and dark themes generated from the brand color
abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      brightness: brightness,
    );

    // In the mockups the light theme buttons are the exact brand blue,
    // and in the dark theme the avatar and FAB use the saturated brand blue
    final scheme = isDark
        ? base.copyWith(
            primaryContainer: AppColors.brand,
            onPrimaryContainer: Colors.white,
          )
        : base.copyWith(primary: AppColors.brand, onPrimary: Colors.white);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
          (states) => TextStyle(
            fontSize: 12,
            color: scheme.onSurface,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
