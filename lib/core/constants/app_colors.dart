import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary - Red (Russian flag inspired)
  static const Color primary = Color(0xFFCC0000);
  static const Color primaryLight = Color(0xFFFF3333);
  static const Color primaryDark = Color(0xFF990000);
  static const Color primarySurface = Color(0xFFFFF0F0);

  // Secondary - Gold
  static const Color secondary = Color(0xFFD4A017);
  static const Color secondaryLight = Color(0xFFFFD700);
  static const Color secondarySurface = Color(0xFFFFFBE6);

  // Success - Green
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF4CAF50);
  static const Color successSurface = Color(0xFFE8F5E9);

  // Error
  static const Color error = Color(0xFFC62828);
  static const Color errorSurface = Color(0xFFFFEBEE);

  // Info - Blue
  static const Color info = Color(0xFF1565C0);
  static const Color infoSurface = Color(0xFFE3F2FD);

  // Neutral
  static const Color background = Color(0xFFF8F6F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0EDE8);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF5A5A7A);
  static const Color textTertiary = Color(0xFF9E9EB5);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Divider
  static const Color divider = Color(0xFFE0DDD8);
  static const Color border = Color(0xFFCECBC5);

  // Russian flag colors
  static const Color russianRed = Color(0xFFCC0000);
  static const Color russianBlue = Color(0xFF003DA5);
  static const Color russianWhite = Color(0xFFFFFFFF);

  // Lesson status colors
  static const Color lessonCompleted = Color(0xFF2E7D32);
  static const Color lessonInProgress = Color(0xFF1565C0);
  static const Color lessonLocked = Color(0xFF9E9E9E);

  // Exercise colors
  static const Color correct = Color(0xFF2E7D32);
  static const Color incorrect = Color(0xFFC62828);
  static const Color neutral = Color(0xFF5A5A7A);
  static const Color selected = Color(0xFF1565C0);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFCC0000), Color(0xFF990000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
