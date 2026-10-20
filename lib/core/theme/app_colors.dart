import 'package:flutter/material.dart';

/// Tonal color families used by stat cards and status chips
enum AppTone { blue, orange, green, red, grey }

/// Background / foreground pair of a tone for the current brightness
typedef ToneColors = ({Color background, Color foreground});

abstract final class AppColors {
  /// Brand blue taken from the Lab 2 mockups (buttons, links, accents)
  static const Color brand = Color(0xFF2F5CB8);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFB26A00);
  static const Color danger = Color(0xFFD32F2F);

  // Carrier brand colors
  static const Color novaPoshta = Color(0xFFDA291C);
  static const Color ukrposhta = Color(0xFFFFC72C);
  static const Color meest = Color(0xFF0061AF);

  /// Light theme uses pastel backgrounds with dark text,
  /// dark theme uses saturated backgrounds with white text
  static ToneColors tone(AppTone tone, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (tone) {
      AppTone.blue => isDark
          ? (background: const Color(0xFF2B3F8C), foreground: Colors.white)
          : (
              background: const Color(0xFFDCE4FF),
              foreground: const Color(0xFF1C3A8A),
            ),
      AppTone.orange => isDark
          ? (background: const Color(0xFF6E4A0E), foreground: Colors.white)
          : (
              background: const Color(0xFFFFDDB0),
              foreground: const Color(0xFF6B4300),
            ),
      AppTone.green => isDark
          ? (background: const Color(0xFF1F5A2A), foreground: Colors.white)
          : (
              background: const Color(0xFFCDEFD1),
              foreground: const Color(0xFF1B5E20),
            ),
      AppTone.red => isDark
          ? (background: const Color(0xFF9A0F0F), foreground: Colors.white)
          : (
              background: const Color(0xFFFFDAD6),
              foreground: const Color(0xFF93000A),
            ),
      AppTone.grey => isDark
          ? (
              background: const Color(0xFF3A3B40),
              foreground: const Color(0xFFE3E2E6),
            )
          : (
              background: const Color(0xFFE4E4EA),
              foreground: const Color(0xFF44474F),
            ),
    };
  }
}
