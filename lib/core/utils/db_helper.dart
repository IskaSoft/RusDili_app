import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../../data/database/database_service.dart';
import '../../core/constants/db_constants.dart';

class DbHelper {
  DbHelper._();

  /// Load image from assets and store as BLOB in app_images table
  static Future<void> seedImageFromAsset({
    required String imageKey,
    required String assetPath,
  }) async {
    try {
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      await DatabaseService.instance.insert(DbConstants.tAppImages, {
        DbConstants.colImageKey: imageKey,
        DbConstants.colImagePath: assetPath,
        DbConstants.colImageBlob: bytes,
      });
    } catch (_) {
      // Asset may not exist yet — skip silently
    }
  }

  /// Get image bytes from DB by key; falls back to null
  static Future<Uint8List?> getImageBlob(String imageKey) async {
    final rows = await DatabaseService.instance.query(
      DbConstants.tAppImages,
      where: '${DbConstants.colImageKey} = ?',
      whereArgs: [imageKey],
    );
    if (rows.isEmpty) return null;
    return rows.first[DbConstants.colImageBlob] as Uint8List?;
  }

  /// Seed all lesson cover images on first run
  static Future<void> seedAllImages() async {
    final imageMap = {
      'lesson_01': 'assets/images/lessons/s01_greetings.png',
      'lesson_02': 'assets/images/lessons/s02_friends.png',
      'lesson_03': 'assets/images/lessons/s03_family.png',
      'lesson_04': 'assets/images/lessons/s04_profession.png',
      'lesson_05': 'assets/images/lessons/s05_nationality.png',
      'lesson_06': 'assets/images/lessons/s06_language.png',
      'lesson_07': 'assets/images/lessons/s07_daily.png',
      'lesson_08': 'assets/images/lessons/s08_adjectives.png',
      'lesson_09': 'assets/images/lessons/s09_time.png',
      'lesson_10': 'assets/images/lessons/s10_myday.png',
      'vocab_doctor': 'assets/images/vocabulary/vocab_doctor.png',
      'vocab_family': 'assets/images/vocabulary/vocab_family.png',
      'vocab_friend': 'assets/images/vocabulary/vocab_friend.png',
      'vocab_book': 'assets/images/vocabulary/vocab_book.png',
      'vocab_hospital': 'assets/images/vocabulary/vocab_hospital.png',
      'vocab_cook': 'assets/images/vocabulary/vocab_cook.png',
      'vocab_park': 'assets/images/vocabulary/vocab_park.png',
      'vocab_dog': 'assets/images/vocabulary/vocab_dog.png',
      'vocab_cat': 'assets/images/vocabulary/vocab_cat.png',
    };

    for (final entry in imageMap.entries) {
      await seedImageFromAsset(imageKey: entry.key, assetPath: entry.value);
    }
  }
}
