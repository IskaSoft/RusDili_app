import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AssetHelper {
  AssetHelper._();

  /// Returns lesson image path for given sapak number
  static String lessonImagePath(int sapakNumber) {
    const map = {
      1: 'assets/images/lessons/s01_greetings.png',
      2: 'assets/images/lessons/s02_friends.png',
      3: 'assets/images/lessons/s03_family.png',
      4: 'assets/images/lessons/s04_profession.png',
      5: 'assets/images/lessons/s05_nationality.png',
      6: 'assets/images/lessons/s06_language.png',
      7: 'assets/images/lessons/s07_daily.png',
      8: 'assets/images/lessons/s08_adjectives.png',
      9: 'assets/images/lessons/s09_time.png',
      10: 'assets/images/lessons/s10_myday.png',
    };
    return map[sapakNumber] ?? 'assets/images/ui/placeholder.png';
  }

  /// Safe Image.asset with fallback placeholder widget
  static Widget safeImage(
    String? path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? placeholder,
  }) {
    final fallback = placeholder ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: borderRadius,
          ),
          child: const Center(
            child: Icon(Icons.image_outlined,
                color: AppColors.textTertiary, size: 28),
          ),
        );

    if (path == null) return fallback;

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }

  /// Emoji icon for each lesson topic
  static String lessonEmoji(int sapakNumber) {
    const emojis = {
      1: '👋',
      2: '🤝',
      3: '👨‍👩‍👧‍👦',
      4: '💼',
      5: '🌍',
      6: '🗣️',
      7: '📅',
      8: '📝',
      9: '🕐',
      10: '🌅',
    };
    return emojis[sapakNumber] ?? '📚';
  }

  /// Category color
  static Color categoryColor(String? category) {
    return switch (category) {
      'greeting' => AppColors.success,
      'family' => AppColors.secondary,
      'profession' => AppColors.info,
      'adjectives' => AppColors.primary,
      'verbs' => const Color(0xFF9C27B0),
      'days' => const Color(0xFF00BCD4),
      'time' => const Color(0xFFFF9800),
      'nationality' => const Color(0xFFE91E63),
      'places' => const Color(0xFF4CAF50),
      'objects' => const Color(0xFF607D8B),
      'animals' => const Color(0xFF795548),
      'basic' => AppColors.textSecondary,
      'identity' => AppColors.primary,
      'language' => const Color(0xFF3F51B5),
      'adverbs' => const Color(0xFF009688),
      'questions' => const Color(0xFFFF5722),
      _ => AppColors.textTertiary,
    };
  }

  /// Category label in Turkmen
  static String categoryLabel(String? category) {
    return switch (category) {
      'greeting' => 'Salam berme',
      'family' => 'Maşgala',
      'profession' => 'Hünär',
      'adjectives' => 'Sypat',
      'verbs' => 'Işlik',
      'days' => 'Hepde günleri',
      'time' => 'Wagt',
      'nationality' => 'Milliýet',
      'places' => 'Ýer',
      'objects' => 'Zatlar',
      'animals' => 'Haýwanlar',
      'basic' => 'Esasy sözler',
      'identity' => 'Şahsyýet',
      'language' => 'Dil',
      'adverbs' => 'Hal',
      'questions' => 'Soraglar',
      _ => 'Beýlekiler',
    };
  }
}
