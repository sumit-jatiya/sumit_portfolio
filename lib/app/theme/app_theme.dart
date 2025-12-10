// -----------------------------------------------------------
// --- THEME SYSTEM | COLORS | FONTS | SHADOWS --------------
// -----------------------------------------------------------

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -----------------------------------------------------------
// --- COLOR PALETTES 🎨
// -----------------------------------------------------------

// ---------------- DARK PALETTE ----------------
const Color darkBackground = Color(0xFF242629);
const Color darkCardColor = Color(0xFF32353A);
const Color darkLinkColor = Color(0xFFEEEEEE);
const Color darkSecondaryText = Color(0xFFB0B0B0);
const Color darkPrimaryAccent = Color(0xFF00ADB5);

// ---------------- LIGHT PALETTE ----------------
const Color lightBackground = Color(0xFFF0F0F0);
const Color lightCardColor = Color(0xFFFFFFFF);
const Color lightLinkColor = Color(0xFF1E1E1E);
const Color lightSecondaryText = Color(0xFF555555);
const Color lightPrimaryAccent = Color(0xFF008C95);

// -----------------------------------------------------------
// --- THEME COLOR FETCHER -----------------------------------
// -----------------------------------------------------------

Map<String, Color> getCurrentColors(bool isDark) {
  return {
    'background': isDark ? darkBackground : lightBackground,
    'cardColor': isDark ? darkCardColor : lightCardColor,
    'primaryAccent': isDark ? darkPrimaryAccent : lightPrimaryAccent,
    'linkColor': isDark ? darkLinkColor : lightLinkColor,
    'secondaryText': isDark ? darkSecondaryText : lightSecondaryText,
  };
}

// -----------------------------------------------------------
// --- GLOBAL PROVIDERS (Riverpod) ----------------------------
// -----------------------------------------------------------

final isDarkThemeProvider = StateProvider<bool>((ref) => true);
final isScrolledProvider = StateProvider<bool>((ref) => false);

// -----------------------------------------------------------
// --- SOFT NEUMORPHIC SHADOWS -------------------------------
// -----------------------------------------------------------

List<BoxShadow> getSoftShadows(
    Color cardColor, Color backgroundColor, bool isDark, bool isPressed) {
  final lightShadowColor =
  isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.08);

  final darkShadowColor =
  isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.08);

  if (isPressed) {
    return [
      BoxShadow(
        color: darkShadowColor,
        offset: const Offset(3, 3),
        blurRadius: 4,
        spreadRadius: -1,
      ),
      BoxShadow(
        color: lightShadowColor,
        offset: const Offset(-3, -3),
        blurRadius: 4,
        spreadRadius: -1,
      ),
    ];
  } else {
    return [
      BoxShadow(
        color: darkShadowColor,
        offset: const Offset(8, 8),
        blurRadius: 20,
      ),
      BoxShadow(
        color: lightShadowColor,
        offset: const Offset(-8, -8),
        blurRadius: 20,
      ),
    ];
  }
}

// -----------------------------------------------------------
// --- FONT STYLES (POPPINS | CLEAN | PROFESSIONAL) ----------
// -----------------------------------------------------------

TextStyle getTitleStyle(Color color, double size) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: color,
    height: 1.1,
  );
}

TextStyle getSubtitleStyle(Color color, double size) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
  );
}

TextStyle getBodyStyle(Color color, double size) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: color,
  );
}
