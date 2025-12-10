import 'package:flutter/material.dart';

class AppColors {
  // ----------------- Primary Brand Colors -----------------
  static const Color primaryNavy = Color(0xFF0A244D);
  static const Color accentPurple = Color(0xFF7B2FF7);
  static const Color neonBlue = Color(0xFF00E5FF);

  // ----------------- Text Colors -----------------
  static const Color textLight = Color(0xFFE9ECF2);
  static const Color textDark = Color(0xFF111827);

  // ----------------- Background Colors -----------------
  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgDark = Color(0xFF0D0D0D);
  static const Color bgDarkCard = Color(0xFF1E1E1E); // For dark cards
  static const Color bgLightCard = Color(0xFFF5F5F5); // For light cards

  // ----------------- Grey Shades -----------------
  static const Color grey = Color(0xFF9CA3AF);
  static const Color greyDark = Color(0xFF1E1E1E);
  static const Color greyLight = Color(0xFFF3F4F6);

  // ----------------- Error / Success Colors -----------------
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF22C55E);

  // ----------------- Gradients -----------------
  static const Gradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF0A244D),
      Color(0xFF7B2FF7),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient neonGradient = LinearGradient(
    colors: [
      Color(0xFF7B2FF7),
      Color(0xFF00E5FF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient bluePurpleGradient = LinearGradient(
    colors: [
      Color(0xFF0A244D),
      Color(0xFF7B2FF7),
      Color(0xFF00E5FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
